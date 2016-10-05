From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: Re: Kernel 4.6.7-rt13: Intel Ethernet driver igb causes huge
 latencies in cyclictest
Date: Wed, 5 Oct 2016 07:02:21 +0000
Message-ID: <584755c2766e4b94a604ece16760fe14@FE-MBX1012.de.bosch.com>
References: <d648628329bc446fa63b5e19d4d3fb56@FE-MBX1012.de.bosch.com>
 <20160922151205.m3cch6re77tox3aw@linutronix.de>
 <c91ce66d47ff470a94e10e2347eafe4a@FE-MBX1012.de.bosch.com>
 <ac1207c12ad34059956c2729ccf31e97@FE-MBX1012.de.bosch.com>
 <20160923123224.odybv2uos6tot6it@linutronix.de>
 <ae35c863cdf246ac8da94277418921ef@FE-MBX1012.de.bosch.com>
 <20160923144140.5tkzeymamrb5qnsv@linutronix.de>
 <a5ea146cf078457ab001131ca0886b0b@FE-MBX1012.de.bosch.com>
 <20160928194519.GA32423@jcartwri.amer.corp.natinst.com>
 <487032ca81f84e70bdacc39a024eff5e@FE-MBX1012.de.bosch.com>
 <20161004193445.GF10625@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="_002_584755c2766e4b94a604ece16760fe14FEMBX1012deboschcom_"
Cc: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:51910 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbcJEHCZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Oct 2016 03:02:25 -0400
In-Reply-To: <20161004193445.GF10625@jcartwri.amer.corp.natinst.com>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--_002_584755c2766e4b94a604ece16760fe14FEMBX1012deboschcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Julia,

> > In the meanwhile I have detected another finding which might be relevan=
t:
> >
> > With the 3.18 kernel the igb driver comes with two interrupts per NIC
> > (e.g. eth2 and eth2-TxRx0) with the 4.6. kernel the igb driver comes wi=
th 9 (!)
> interrupts per NIC:
> > eth2, and eth2-TxRx-0, eth2-TxRx-1, ... , eth2-TxRx-7.
> >
> > As I have used initially the same kernel configuration from 3.18 also
> > for the 4.6. kernel I wonder where this comes from and if there is any
> > kernel option I may use to disable these many interrupts and to reduce
> > it to 2 again.
>=20
> If it's all of these interrupts that are firing and being handled at the =
same time, that
> can account for the latencies you were seeing.  As I suggested before, ha=
ving a
> trace with the sched_wakeup event enabled can help confirm that it's thes=
e
> interrupts causing problems.
>=20
> If it is true, then the question is: why is the device triggering all of =
these interrupts all
> at once?  Is that expected?  These are questions for netdev folks, I thin=
k.
>=20
>    Julia

OK - I ran again the cyclictest. This time I used the -C option:
# cyclictest -a -i 100 -m -n -p 80 -t 1 -b 21 -C

And the last output lines of the trace are:
cyclicte-5887    0d...2.. 1504647266us!: sched_switch: prev_comm=3Dcyclicte=
st prev_pid=3D5887 prev_prio=3D19 prev_state=3DS =3D=3D> next_comm=3Dkworke=
r/0:0 next_pid=3D5 next_prio=3D120
kworker/-5       0dN.h2.. 1504647372us : sched_wakeup: comm=3Dcyclictest pi=
d=3D5887 prio=3D19 target_cpu=3D000
kworker/-5       0dN.h3.. 1504647374us : sched_wakeup: comm=3Dirq/54-eth2-T=
xR pid=3D5883 prio=3D49 target_cpu=3D000
kworker/-5       0dN.h3.. 1504647375us : sched_wakeup: comm=3Dirq/53-eth2-T=
xR pid=3D5882 prio=3D49 target_cpu=3D000
kworker/-5       0dN.h3.. 1504647377us : sched_wakeup: comm=3Dirq/52-eth2-T=
xR pid=3D5881 prio=3D49 target_cpu=3D000
kworker/-5       0dN.h3.. 1504647378us : sched_wakeup: comm=3Dirq/51-eth2-T=
xR pid=3D5880 prio=3D49 target_cpu=3D000
kworker/-5       0dN.h3.. 1504647380us : sched_wakeup: comm=3Dirq/50-eth2-T=
xR pid=3D5879 prio=3D49 target_cpu=3D000
kworker/-5       0dN.h3.. 1504647381us : sched_wakeup: comm=3Dirq/49-eth2-T=
xR pid=3D5878 prio=3D49 target_cpu=3D000
kworker/-5       0dN.h3.. 1504647382us : sched_wakeup: comm=3Dirq/48-eth2-T=
xR pid=3D5877 prio=3D49 target_cpu=3D000
kworker/-5       0dN.h3.. 1504647383us : sched_wakeup: comm=3Dirq/47-eth2-T=
xR pid=3D5876 prio=3D49 target_cpu=3D000
kworker/-5       0d...2.. 1504647384us : sched_switch: prev_comm=3Dkworker/=
0:0 prev_pid=3D5 prev_prio=3D120 prev_state=3DR+ =3D=3D> next_comm=3Dcyclic=
test next_pid=3D5887 next_prio=3D19
cyclicte-5887    0.....11 1504647389us : tracing_mark_write: hit latency th=
reshold (28 > 21)

The attached trace-extract.gz shows some more lines.
It actually looks to me as if the the many irq threads from igb are causing=
 the issue.

Regards

Mathias


--_002_584755c2766e4b94a604ece16760fe14FEMBX1012deboschcom_
Content-Type: application/x-gzip; name="trace-extract.gz"
Content-Description: trace-extract.gz
Content-Disposition: attachment; filename="trace-extract.gz"; size=1191;
	creation-date="Wed, 05 Oct 2016 07:00:30 GMT";
	modification-date="Wed, 05 Oct 2016 06:48:54 GMT"
Content-Transfer-Encoding: base64

H4sICFai9FcAA3RyYWNlLWV4dHJhY3QA1ZnLkps4FIb3/RTMblIpaN0lXON+hCyS2Xe5MImpvtgD
OE7ePoDAEiCBkO0pt1dtt+3/87n85wiS38lrlpRpSIXgQfUA2yiKUBQFkALCCKNUHIvPq6BIdun2
uThlZbJbBYc8/fmc7N/e1kn7BUUpXzxk23XzXfJZnu3XMJZPinJTputvwXr9FLynv0r5BcVpczik
+SOQr9Wf7/5sPozAQxD8k21f06cQBPIBtl+iHVaQjLJjEXSQp81LejysghGfQpNU5Sb/kVYYh+Ma
AKNMPxaMck1mHAv1U86hAHocENAD8XUQCI30HIkGVwtG/JDMJYzdY8LwIGHcnrA8OSaPuEkWoTJV
seinCo8F+EIB3giI2CzAxwJwoQBsBBA2C8CxAF0oQBsBxs0CdL5peK+ar9Y0xF2m+R1ESjDz7yBj
AbZQgDUCXJgF2FgALRRAjQAmZgFk7obITeClzN7SvNh/L7ddU1giZWkKDx3ZGzFY1BseOm2LWOJm
aBHgpwNk3MwyhgqmfjJtQ1rqzNCQzE+nrWeLdVnq2UOnLWuLBxvKmvjptAZgMTKDAeDBxOP1xHMY
y9hrLLfz6DzrqqGkhl0sTF3nh8f98bjCq0baNN5wX3DFu+VSY3AUP0joH0OoABGeiSH1xKP+eFTh
MT6DxzzxmD8eU3jVpJ3GQ554yB8PKbxqTk/jEU884o9HtOZgQzxpQGHlOxb3iyfxun26YyNUg4vF
1KbfXz6UA5oReVh5j8UBHRA1+xOxF6LmgjEwIsKwam2LwTggau6CsBeibjKDOpw92M0hXnyw6+9M
Kt3GUNKQcZsZOoRSc0LGvUKpG+LIcaQnhZUVWQzRAVFzQy68EHVTHI1l6UthZUcWU3RA1BwREy9E
3RhHi430prCyJLMxMjCPqLkiZV6IujkOJl/3tjAGFueZQRwcezrSGDiTqu3NejXkTEmYxcIXUOpO
7h5PtQLPUyJiscgFlLpTuhem2uLmKZmwuM8CSt2E3DtcLXPzlDy2GBCDzpS6D7kPRrXTzVNiavGg
BZS6FblvGGq1m6ek3GZD7pS6G7mPHbXhOfS4fszCEClKZD0Mn/b5S33CWskrFe2Ju14cB5cqHFTw
nMoRspW88kIxIQulemGnk9eZB1dgzqblPgO0sKgJMIx7+6aQnjG/RDsNU1zlKqdBph8NMXNI6OX4
XIITx4TPt7k7IG6+RPbKTKHWtWZLXf0/E2vdMn/Nx7St6DOuLGtLYG9TZTG/xg2o2Srry9xvlcX8
xvegrpI1DuyefMWsVTL4I2St4iST/XYnWYMc/B9Z68vcb9Yghx+h11BdXLfPGqq3kg+QNcTYR+g1
zG/kkL07rJWMtTiy/L9HSsK03KHw319fO632vjrx0aKTWnikhS7Qsi6fjRYaacELtMSkFhxpAX8t
YbXgRgsMtbq7lV5acEqLxCMtcYGWtdwbLTHS4hdoWY9qjRYfabEFWn23wYLcpytG9QNCxSlPJ2W+
SbL3H89vm/zl+ZRnZboKdlkZvFbi78nvoNzlabHbv26Dv5EIngIEPz38AXm9cPPKJgAA

--_002_584755c2766e4b94a604ece16760fe14FEMBX1012deboschcom_--

