# Ducky-DNS
Small ruby script to update a Gandi domain zone

## Things

Go to [https://www.duckdns.org/domains](https://www.duckdns.org/domains), get your token, save it as `.apitoken`.

Use a ACME client (such as [my fork of acme-tiny](https://github.com/conchyliculture/acme-tiny/tree/dns-01)) which uses hooks to update your DNS zone.

Write a wrapper around `ducky.rb` to do the things, or if you use my fork, you can have the ACME client use `dns-01.rb` as a hook.

This should probably work.
