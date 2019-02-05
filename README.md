# Directory backup

Create a backup for the targeted directory

## How does it work

It creates a new directory named ```<target>_SAVE``` which will be your backup

### Personal advice

Add an alias on your _.bashrc_

```
alias svrd="bash srvd.sh"
```

## How to use it

```
svrd <options> <target>
```

Options are optional.
There's 2 options :
* -b : brute
* -h : hide 
