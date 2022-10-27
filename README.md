## MIME types

[![Donate via Stripe](https://img.shields.io/badge/Donate-Stripe-green.svg)](https://buy.stripe.com/00gbJZ0OdcNs9zi288)<br>
[![Donate via Bitcoin](https://img.shields.io/badge/Donate-Bitcoin-green.svg)](bitcoin:37fsp7qQKU8XoHZGRQvVzQVP8FrEJ73cSJ)<br>

This is a simple class that feteches and caches the MIME types associated with file formats.

It gets them from iana.org.

It also automatically associates the .js file format with the .javascript file format.

Depends on my lua-ext and lua-csv projects.

Expects luasocket, curl, or wget to be installed for downloading the file.
