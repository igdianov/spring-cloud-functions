FROM ubuntu

#CMD ["exec", "/bin/sh", "-c", "trap : TERM INT; (while true; do sleep 1000; done) & waittrap : TERM INT; (while true; do sleep 1000; done) & wait"]
CMD ["/bin/sh", "-c", "echo Hiiiiiii"]
