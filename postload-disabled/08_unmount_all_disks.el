;;; postload/08_unmount_all_disks.el -*- lexical-binding: t; -*-

(defun unmount-all-external-disks ()
  "Unmount all external disks using sudo -S umount."
  (interactive)
  (shell-command (concat "echo " (shell-quote-argument (read-passwd "Password? "))
                         " | sudo -S umount /run/media/iani/*"))
  (message "Discs ejected. Please check message from OS."))
