default[:system][:hostname] = ""

### Users 
default[:users][:default_users] = [ "ja" ]
default[:users][:sudoers] = [ "ja" ]

default[:users][:authorized_keys] = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDOqfh5MwjPQyqnfyRMnSu8yIN3LhLkA6tIrBQbr3/pNhp//DNxC01vhRT6iaCEjmsGwQiOVUpdL0vBmXGP9uRGeCnNk33EQS+CKOPYyLWz0ZeCijFQigO0eF3UDKHkhKQ5c6Ik4mEAQ6Q2GV/gU0w4E2ZTga0j6HDjRbQI9LGTAWmkrncQmUS4IHeMrKI68p4q20jOjpGl8VVxqO3ke78f7ug4ZRTSUOmnJTLzWYPs6xEa4HLaEolL00rRN338GWhmd62oCVQANQryL7Qld349c/2d2/gf7vAeKUahc2qcTCIrlyVUtf0ymvIFGEvPvxexY/+VCRe6hHp9jMlg8S68KkMrzEWigonI8Hg/lB5xl+nyA7YLF5w6yD36HdWfyu+M+WIC90aH1p2xJ4K3OUxokgtow/3dY31za5YJScX079BDbxbjW7TLFxH4NLjvWjsREmVbNRfTUbzNRpj2xaEXswfealCArSLN48a8yW7KiBg2dvbO+ckwWPzCWNYs7uLOg2sOvdHoLaKEelWGP1m2dl+tKfzG8KH/lqRtTTuqhOmEh1JQh5wn4ngnMe/+CsqSfCfR9abVInMnNNPdcX8VboodQR2EDE2Ng0xbfxc1PFOQT/cveecPZU+y75tH+rlIKyfC8Ahnj4JYfxa49KmnnPu7MNqfmq9kx9ZBxw+Z2w== JAMIE-ALQUIZA-PRIMARY"]

# Software
default[:software][:default_packages] = [ "zsh", "htop", "atop", ]
