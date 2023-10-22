import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";

type TodoTableDialogProps = {
  trigger: React.ReactNode;
  title: string;
  description?: string;
  content: React.ReactNode;
  footer?: React.ReactNode;
  isOpen?: boolean;
  onOpenChange?: (open: boolean) => void;
};

const TodoTableDialog: React.FC<TodoTableDialogProps> = ({
  trigger,
  title,
  description,
  content,
  footer,
  isOpen = false,
  onOpenChange = () => {},
}) => {
  return (
    <Dialog key={title} open={isOpen} onOpenChange={onOpenChange}>
      <DialogTrigger asChild>{trigger}</DialogTrigger>
      <DialogContent className="sm:max-w-[700px]">
        <DialogHeader>
          <DialogTitle>{title}</DialogTitle>
          <DialogDescription>{description}</DialogDescription>
        </DialogHeader>
        {content}
        <DialogFooter>{footer}</DialogFooter>
      </DialogContent>
    </Dialog>
  );
};

export { TodoTableDialog };
