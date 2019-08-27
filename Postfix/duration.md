# Configuring retry duration in Postfix
By default, Postfix (like most mailservers) will keep trying to deliver mail for unconscionably long periods of time – 5 days. Most users do NOT expect mail that isn’t getting delivered to just sorta hang out for 5 days before they find out it didn’t go through – the typical scenario is that a mistyped email address (or a receiving mailserver that decides to SMTP 4xx you instead of SMTP 5xx you when it really doesn’t want that email, ever) means that three or four days later, the message still hasn’t gotten there, the user has no idea anything went wrong, and then there’s a giant kerfuffle “but I sent that to you days ago!”

If you want to reconfigure Postfix to something a little more in tune with modern sensibilities, add the following to /etc/postfix/main.cf near the top:

```bash
maximal_queue_lifetime = 1h
maximal_backoff_time = 15m
minimal_backoff_time = 5m
queue_run_delay = 5m
```

Note that this will cause you problems if you need to deliver to someone who has a particularly aggressive graylisting setup in place that would require retries at or near a full hour later from the original bounce that it sends you. But that’s okay – greylisting is bad, and the remote admin should FEEL bad for doing it. (Alternately – adjust the numbers above as desired to 2h, 4h, whatever will allow you to pass the greylisting on the remote end. Ultimately, you’re the one who has to answer to your users about a balance between “knowing right away that the mail didn’t go through” vs “managing to survive dumb things the other mail admin may have done on his end”.)
