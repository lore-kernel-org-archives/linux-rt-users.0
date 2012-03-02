From: Steven Rostedt <rostedt@goodmis.org>
Subject: Stressing CPU hotplug
Date: Fri, 02 Mar 2012 15:35:16 -0500
Message-ID: <1330720516.25686.272.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-hdsKhq+RxOSCiebBMsqI"
Cc: Clark Williams <clark@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>, Carsten Emde <cbe@osadl.org>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:24511 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116Ab2CBUfT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Mar 2012 15:35:19 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-hdsKhq+RxOSCiebBMsqI
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit

If anyone wants to test their hotplug code, attached is as simple script
that does up to 12 CPUs. It enables and disables them in a binary
progression.

-- Steve


--=-hdsKhq+RxOSCiebBMsqI
Content-Type: application/x-shellscript; name="stress-cpu-hotplug"
Content-Disposition: attachment; filename="stress-cpu-hotplug"
Content-Transfer-Encoding: 7bit

#!/bin/bash

MAXCPUS=12

# find cpus

CPUS=`ls -d /sys/devices/system/cpu/cpu[1-9]*`
NR=`echo $CPUS | wc -w`

let x=0
for cpu in $CPUS; do
    file=$cpu/online
    CPUONLINE[$x]=$file
    ENB[$x]=`cat $file`
    CPU[$x]=`basename $cpu`
    let x=$x+1
done

let MAXCNT=$x

MSKCNT=$MAXCNT

if [ $MAXCNT -gt $MAXCPUS ]; then
    MSKCNT=$MAXCPUS
fi

let MSKCNT=2**$MSKCNT

hotplug() {
    MSK=$1
    ECHO="$MSK"
    CMD=""
    x=0
    while [ $MSK -gt 0 ]; do
	let bit=$MSK'&'1
	if [ $bit -eq 1 ]; then
	    if [ ${ENB[$x]} -eq 1 ]; then
		cmd="disabling"
		ENB[$x]=0
		num=0
	    else
		cmd="enabling"
		ENB[$x]=1
		num=1
	    fi
	    CMD="$CMD echo $num > ${CPUONLINE[$x]};"
	    ECHO="$ECHO $cmd ${CPU[$x]}"
	fi
	let x=$x+1
	let MSK=$MSK'>>'1
    done
    echo $ECHO
    eval $CMD
}

let MSKCNT=$MSKCNT-1
for i in `seq $MSKCNT`; do
    hotplug $i
done
for i in `seq $MSKCNT`; do
    hotplug $i
done

exit 0

--=-hdsKhq+RxOSCiebBMsqI--

