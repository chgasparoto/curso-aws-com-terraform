'use strict'

const AWS = require('aws-sdk')
const Joi = require('joi')

const S3 = new AWS.S3()
const SNS = new AWS.SNS()

const schema = Joi.object().keys({
    TodoId: Joi.string().required(),
    Task: Joi.string().required(),
    Done: Joi.string()
})

const getFileContent = async (S3, bucket, filename) => {
    const params = {
        Bucket: bucket,
        Key: filename
    }

    const file = await S3.getObject(params).promise()
    return JSON.parse(file.Body.toString('ascii'))
}

const isItemValid = (data) => {
    const isValid = schema.validate(data)
    return isValid.error === undefined
}

const publish = async (SNS, payload) => {
    const { message, subject, topic } = payload
    const params = {
        Message: message,
        Subject: subject,
        TopicArn: topic
    }

    try {
        await SNS.publish(params).promise()
        console.log(`Message published: ${message}`)
        return true
    } catch (error) {
        console.error(error)
        return false
    }
}

exports.handler = async (event) => {
    if (process.env.DEBUG) {
        console.log(`Received event: ${JSON.stringify(event)}`)
    }

    const topicArn = event.topicArn || process.env.TOPIC_ARN
    if (!topicArn) {
        throw new Error('No topic defined.')
    }

    const { s3 } = event.Records[0]
    const content = await getFileContent(S3, s3.bucket.name, s3.object.key)
    let count = 0

    for (let item of content) {
        if (!isItemValid(item)) {
            console.log(`Invalid item found: ${JSON.stringify(item)}`)
            return false
        }

        await publish(SNS, {
            message: JSON.stringify(item),
            subject: 'Data from S3',
            topic: topicArn
        })

        count++
    }

    return `Published ${count} messages to the Topic.`
}
