From: Darcy Watkins <dwatkins@tranzeo.com>
Subject: Re: 2.6.33.6-rt28 kernel oops while stressing network
Date: Fri, 13 Aug 2010 12:56:35 -0700
Message-ID: <1281729395.27281.24.camel@tr-pentomino>
References: <AANLkTi=NBDyUAL=JpUV4h1-syFS3n=Z9aNxAM+eNoHW6@mail.gmail.com>
	 <AANLkTi=tPSeXTZkjPPm_MGmmOx2fZhryOkajgssv0EsX@mail.gmail.com>
	 <AANLkTinOmnq0hxL9TaZAuu0x5LORAOKuGYFUam9fMzzo@mail.gmail.com>
	 <AANLkTimnHPhLSxgiX3rrFso-1NKsvp++tHxwGCvqO-Cq@mail.gmail.com>
	 <D61182AC8012EA4EBC531B3AF23BE1099C86D3@tranzeo-mail2.12stewart.tranzeo.com>
	 <AANLkTikty=V_==0udO9F2MxpVxwuLzyOQZt0ha5=VC3y@mail.gmail.com>
	 <D61182AC8012EA4EBC531B3AF23BE1099C86D6@tranzeo-mail2.12stewart.tranzeo.com>
	 <AANLkTi=3cz2RyHPdoNRjucTozKqDmJc8sDh+hsnmhKAS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-9o40/M3tjYTdN/huUaSj"
Cc: linux-rt-users@vger.kernel.org
To: John Culvertson <jculvertson@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.tranzeo-emc.com ([64.114.87.10]:11125 "EHLO
	mail2.tranzeo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab0HMT4i (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Aug 2010 15:56:38 -0400
In-Reply-To: <AANLkTi=3cz2RyHPdoNRjucTozKqDmJc8sDh+hsnmhKAS@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-9o40/M3tjYTdN/huUaSj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi John,

First of all, you will want to become familiar with the 'chrt' command
(available also as an applet part of busybox).  That command (plus some
of the finer details in optional output from the 'ps' command) is how
you will tweak and experiment on a target system.

Then the attached may be of use (I attached them because they are
small).  rtctl is a package that originates from Red Hat.  If you are
using busybox shell (rather than full blown bash), then apply the
attached patch to it.

Extract the rpm something like...

rpm2cpio rtctl-1.7-1.el5rt.src.rpm | cpio --extract --make-directories

...assuming you have rpm2cpio installed on your host.  Then extract any
tarballs that were bundled inside it.  Then apply the attached patch to
it (if not using bash on your target).

Then install to your target rootfs staging area something like...

install -D -m 755 rtctl $MY_STAGING_DIR_PATH/usr/sbin/rtctl
install -D -m 644 rtgroups $MY_STAGING_DIR_PATH/etc/rtgroups
install -D -m 755 rtctl.sysconfig
$MY_STAGING_DIR_PATH/etc/sysconfig/rtctl 

The package includes more but that's all I've ported and tried out so
far on a uclibc/buildroot style embedded Linux with RT kernel so far.

Edit the rtgroups file accordingly to implement an RT policy that works
for you (based on outcome of your experiments using chrt).

What hasn't been implemented yet is how to hook rtctl into your system
initialization scripts.  The stock content from the Red Hat package is
for their real time distro.  You'd need to invoke it from your scripts
accordingly.


Regards,

Darcy

On Fri, 2010-08-13 at 12:16 -0700, John Culvertson wrote:
> Thanks for the pointers.  I have seen others mention adjusting the
> soft irq thread priorities, etc.  Can you shed any light on how to go
> about doing that?  Is that in the kernel configuration, or do you have
> to modify the kernel source?
> 
> On Fri, Aug 13, 2010 at 2:14 PM, Darcy Watkins <DWatkins@tranzeo.com>
> wrote:
> > Hi John,
> >
> > In the 'make menuconfig', look for and double check any config
> settings related to IRQ sharing, PCI, etc.  There are a lot of
> tweaks.  Probably enough to write a PhD dissertation about.
> >
> > The other thing, if it only happens under high network stress, you
> may want to check into tweaking the real time priorities of your
> kernel threads, user space program threads and even IRQ threads.  RT
> kernels tend to treat priorities more strictly so it is possible for a
> high priority thread to hog the CPU and deplete resources before a
> lower priority thread processes them and frees up the resources.
> >
> > Regards,
> >
> > Darcy
> >
> >
> > -----Original Message-----
> > From: John Culvertson [mailto:jculvertson@gmail.com]
> > Sent: Friday, August 13, 2010 11:06 AM
> > To: Darcy Watkins
> > Subject: Re: 2.6.33.6-rt28 kernel oops while stressing network
> >
> > Thanks for the suggestions.  I have tried the unpatched 2.6.33.7
> > kernel, and the problem does not occur.  The hardware is a single
> > board industrial computer with the network controllers onboard, so I
> > cannot easily try different NICs.  I have not seen the problem occur
> > with only one port in use, but I have not tested that long enough to
> > be positive.
> >
> > One thing that may be a little odd about this computer is that both
> > Ethernet controllers (Intel 82559) share the same PCI interrupt.
> > Interrupt sharing should be OK, but since adjacent PCI slots in
> normal
> > PCs generally use different interrupts, it may not occur often in
> > other systems.
> >
> > On Fri, Aug 13, 2010 at 1:56 PM, Darcy Watkins
> <DWatkins@tranzeo.com> wrote:
> >> Hi John,
> >>
> >> I use Fedora 13 which has 2.6.33.6 as the kernel (without RT).
> >>
> >> My machine has three net i/f in it.  Two PCI net cards with Realtek
> >> chipset and Intel PRO built into the mainboard's chipset.
> >>
> >> When I installed Fedora using the netboot USB flash drive, it
> insisted
> >> on using one of the Realtek interfaces for Internet connection so
> that
> >> is my eth0.  All fine.
> >>
> >> More recently, I activated the other two net i/f for private LAN to
> >> target HW test network.  I set one to 10.0.0.1 and the other to
> >> 192.168.101.4 and connected them to the target network.  Note that
> they
> >> were both connected to the same network switch.
> >>
> >> Shortly after that, the system froze.  After reboot it would run
> for a
> >> while and then freeze.  I unplugged the net i/f based on the Intel
> PRO
> >> and all has been fine since.
> >>
> >> I mention all this because you once mentioned you were using two
> Intel
> >> net i/f.  It may not even be RT related.
> >>
> >> I suggest you try (not in any particular order, but each on its
> own)...
> >>
> >>   - running with only one net i/f connected
> >>   - building a side-by-side vanilla kernel 2.6.33.7 (without RT
> patch)
> >> and running your two net i/f without RT
> >>   - using different net i/f cards (say based on Realtek or
> something
> >> other than Intel) try running it with RT
> >>
> >> If you see your system behavior change related to any of these, it
> >> possibly may not be RT patch related (or it could be tied to a
> specific
> >> driver).
> >>
> >> Regards,
> >>
> >> Darcy
> >>
> >> -----Original Message-----
> >> From: linux-rt-users-owner@vger.kernel.org
> >> [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of John
> >> Culvertson
> >> Sent: Friday, August 13, 2010 10:38 AM
> >> To: linux-rt-users@vger.kernel.org
> >> Subject: Re: 2.6.33.6-rt28 kernel oops while stressing network
> >>
> >> Since it was my understanding that x86 was the most mature and
> stable
> >> architecture for preempt-rt, I was surprised when I immediately
> >> encountered problems.  Is this typical when trying the patches on a
> >> new platform?  Like I mentioned before, I am a newbie with
> preempt-rt.
> >>
> >> On Wed, Aug 11, 2010 at 12:53 PM, John Culvertson
> >> <jculvertson@gmail.com> wrote:
> >>> I updated to 2.6.33.7-rt29, and I am seeing similar symptoms.
> >>>
> >>> [ 2120.781166] BUG: unable to handle kernel paging request at
> c11cd497
> >>> [ 2120.784018] IP: [<c11d5ce2>] tcp_set_skb_tso_segs+0x33/0x85
> >>> [ 2120.784018] *pde = 1d7f6063 *pte = 011cd161
> >>> [ 2120.784018] Oops: 0003 [#1] PREEMPT
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> >> linux-rt-users" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> 
> 


--=-9o40/M3tjYTdN/huUaSj
Content-Disposition: attachment; filename="10-rtctl-crossbuild-tsf.patch"
Content-Type: text/x-patch; name="10-rtctl-crossbuild-tsf.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Index: rtctl-1.7/rtctl
===================================================================
--- rtctl-1.7.orig/rtctl
+++ rtctl-1.7/rtctl
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 usage ()
 {
@@ -26,67 +26,62 @@ shift
 
 GROUPNAME=""
 
+ALL_GROUPS=`awk '/^[a-zA-Z_0-9-]+:[*orbf]:[0-9]+:.+$/ { split($0, parts, ":") ; print parts[1] }' ${RTGROUPFILE}`
+
+group_properties_of()
+{
+	local grouprec=`awk '/^[a-zA-Z_0-9-]+:[*orbf]:[0-9]+:[*a-fA-F0-9]+:.+$/ { split($0, parts, ":") ; if (parts[1] == groupname) print }' groupname=$1 ${RTGROUPFILE}`
+	if [ -n "$grouprec" ] ; then
+		# 5 field record format
+		GROUP_AFFINITY=`echo $grouprec | cut -d ':' -f 4`
+		GROUP_REGEX=`echo $grouprec | cut -d ':' -f 5`
+	else
+		grouprec=`awk '/^[a-zA-Z_0-9-]+:[*orbf]:[0-9]+:.+$/ { split($0, parts, ":") ; if (parts[1] == groupname) print }' groupname=$1 ${RTGROUPFILE}`
+		if [ -n "$grouprec" ] ; then
+			# 4 field legacy record format
+			GROUP_AFFINITY="*"
+			GROUP_REGEX=`echo $grouprec | cut -d ':' -f 4`
+		else
+			return 1
+		fi
+	fi
+	local gname=`echo $grouprec | cut -d ':' -f 1`
+	GROUP_SCHED=`echo $grouprec | cut -d ':' -f 2`
+	GROUP_PRIORITY=`echo $grouprec | cut -d ':' -f 3`
+	GROUP_PIDS=`ps -eo pid,cmd | fgrep -v $GROUP_REGEX | egrep $GROUP_REGEX | awk '{ print $1 }'`
+	return 0;
+}
+
 #
 # print the PIDs of processes belonging to ${GROUPNAME} as defined
 # in ${RTGROUPFILE}.
 #
 group_pids ()
 {
-  ps -eo pid,cmd | awk '
-    /^[a-zA-Z_0-9-]+:[*orbf]:[0-9]+:.+$/ {
-      split($0, parts, ":") 
-      if (parts[1] == groupname) {
-	  nr_rules += 1
-	  regexp_offset = length(parts[1]) + length(parts[2]) + length(parts[3]) + 4
-	  if (length(parts) > 4) {
-	    regexp_offset += length(parts[4]) + 1
-	  }
-	  group_regexps[nr_rules] = substr($0,regexp_offset)
-      }
-    }
-    /^ *[0-9]+ .+$/ {
-      for (i = 1; i <= nr_rules; ++i) {
-	if (match($2, group_regexps[i])) {
-          print $1
-	  break
-        }
-      }
-    }' groupname=${GROUPNAME} ${RTGROUPFILE} -
+	if group_properties_of ${GROUPNAME} ; then
+		echo "$GROUP_PIDS"
+	else
+		return 1
+	fi
+	return 0
 }
 
 
 set_group_defaults ()
 {
-  ps -eo pid,cmd | awk '
-    /^[a-zA-Z_0-9-]+:[*orbf]:[0-9]+:.+$/ {
-      split($0, conf, ":")
-      if (groupname == "" || conf[1] == groupname) {
-        nr_rules += 1
-        group_sched[nr_rules] = conf[2]
-        group_prio[nr_rules] = conf[3]
-	regexp_offset = length(conf[1]) + length(conf[2]) + length(conf[3]) + 4
-	if (length(conf) < 5) {
-	  group_affinity[nr_rules] = "*"
-	} else {
-	  regexp_offset += length(conf[4]) + 1
-	  group_affinity[nr_rules] = conf[4]
-	}
-        group_regexps[nr_rules] = substr($0,regexp_offset)
-      }
-    }
-    /^ *[0-9]+ .+$/ {
-      for (i = nr_rules; i >= 1; --i) {
-	if (match($2, group_regexps[i])) {
-	  if (group_sched[i] != "*") {
-            print "chrt -p -" group_sched[i] " " group_prio[i] " " $1
-	  }
-	  if (group_affinity[i] != "*") {
-            print "taskset -p " group_affinity[i] " " $1 " > /dev/null"
-	  }
-          break
-        }
-      }
-    }' groupname=${GROUPNAME} ${RTGROUPFILE} - | sh
+	if group_properties_of ${GROUPNAME} ; then
+		for pid in $GROUP_PIDS ; do
+			if [ "$GROUP_SCHED" != "*" ] ; then
+				chrt -p -$GROUP_SCHED $GROUP_PRIORITY $pid
+			fi
+			if [ "$GROUP_AFFINITY" != "*" ] ; then
+				taskset -p $GROUP_AFFINITY $pid > /dev/null
+			fi
+		done
+	else
+		return 1
+	fi
+	return 0
 }
 
 
@@ -149,8 +144,13 @@ case "$CMD" in
         [ $# -gt 1 ] && usage
         if [ $# -ne 0 ]; then
             GROUPNAME=$1
+	        set_group_defaults
+		else
+			for grp in $ALL_GROUPS ; do
+	            GROUPNAME=$grp
+		        set_group_defaults
+			done
         fi
-        set_group_defaults
 	;;
 
     "show")

--=-9o40/M3tjYTdN/huUaSj
Content-Type: application/x-rpm; name="rtctl-1.7-1.el5rt.src.rpm"
Content-Disposition: attachment; filename="rtctl-1.7-1.el5rt.src.rpm"
Content-Transfer-Encoding: base64

7avu2wMAAAEA/3J0Y3RsLTEuNy0xLmVsNXJ0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAABAAUAAAAAAAAAAAAAAAAAAAAAjq3oAQAAAAAAAAAHAAAA2AAA
AD4AAAAHAAAAyAAAABAAAAELAAAABwAAAAAAAABBAAABDQAAAAYAAABBAAAAAQAAA+gAAAAEAAAA
bAAAAAEAAAPsAAAABwAAAHAAAAAQAAAD7QAAAAcAAACAAAAAQQAAA+8AAAAEAAAAxAAAAAGIPwMF
AEseUwxeA/3lHR4DSxECGg0An1bVNe/L0NH6WxeOWI4Zz8mM47Q2AJ0WR4NnTL8ZezRKEPB/kbrU
GKkjfjg0NzA3ODc3ZjA1NTU0NGM4NjAzNzc4MTM3YTRjNDE2YmNjZWIxMjAAAAAAACXlZVirX3Cu
hO2rM1MsIvb48Ig/AwUASx5TDF4D/eUdHgNLEQJo8QCeP6d+wXyC4m2Var9hek+8JlKoe54AniU8
DQmiUAcPrl8BWHjwqWnQ5sHJAAAAAABBEAAAAD4AAAAH////kAAAABCOregBAAAAAAAAAC8AAAxg
AAAAPwAAAAcAAAxQAAAAEAAAAGQAAAAIAAAAAAAAAAEAAAPoAAAABgAAAAIAAAABAAAD6QAAAAYA
AAAIAAAAAQAAA+oAAAAGAAAADAAAAAEAAAPsAAAACQAAABQAAAABAAAD7QAAAAkAAABUAAAAAQAA
A+4AAAAEAAAAuAAAAAEAAAPvAAAABgAAALwAAAABAAAD8QAAAAQAAADcAAAAAQAAA/IAAAAGAAAA
4AAAAAEAAAPzAAAABgAAAOUAAAABAAAD9gAAAAYAAADzAAAAAQAAA/cAAAAGAAAA9wAAAAEAAAP4
AAAACQAAASsAAAABAAAD+gAAAAgAAAE/AAAABgAAA/0AAAAGAAABfAAAAAEAAAP+AAAABgAAAYIA
AAABAAAEBAAAAAQAAAGMAAAABwAABAYAAAADAAABqAAAAAcAAAQJAAAAAwAAAbYAAAAHAAAECgAA
AAQAAAHEAAAABwAABAsAAAAIAAAB4AAAAAcAAAQMAAAACAAAAscAAAAHAAAEDQAAAAQAAALQAAAA
BwAABA8AAAAIAAAC7AAAAAcAAAQQAAAACAAAAzIAAAAHAAAEFQAAAAQAAAN4AAAABwAABBgAAAAE
AAADlAAAAAEAAAQZAAAACAAAA5gAAAABAAAEGgAAAAgAAAO0AAAAAQAABCgAAAAGAAADvAAAAAEA
AAQ4AAAABAAAA8QAAAAMAAAEOQAAAAgAAAP0AAAADAAABDoAAAAIAAAGHQAAAAwAAARBAAAACAAA
C2gAAAABAAAERgAAAAYAAAtvAAAAAQAABEcAAAAEAAALmAAAAAcAAARIAAAABAAAC7QAAAAHAAAE
SQAAAAgAAAvQAAAABwAABFwAAAAEAAAL2AAAAAcAAARdAAAACAAAC/QAAAAHAAAEXgAAAAgAAAw8
AAAAAQAABGQAAAAGAAAMPQAAAAEAAARlAAAABgAADEIAAAABAAAEZgAAAAYAAAxHAAAAAQAABHsA
AAAIAAAMSQAAAAdDAHJ0Y3RsADEuNwAxLmVsNXJ0AFNjcmlwdHMgZm9yIGNvbnRyb2xsaW5nIHNj
aGVkdWxpbmcgcHJpb3JpdGllcyBvZiBzeXN0ZW0gdGhyZWFkcwBydGN0bCBpcyBhIHNldCBvZiBz
Y3JpcHRzIHVzZWQgdG8gbWFuaXB1bGF0ZSB0aGUgc2NoZWR1bGluZyBwcmlvcml0aWVzIG9mCmdy
b3VwcyBvZiBzeXN0ZW0gdGhyZWFkcy4ASosJe3g4Ni0wMDQuYnVpbGQuYm9zLnJlZGhhdC5jb20A
AAAAAAA9OEtvamkAUmVkIEhhdCwgSW5jLgBHUEwAUmVkIEhhdCwgSW5jLiA8aHR0cDovL2J1Z3pp
bGxhLnJlZGhhdC5jb20vYnVnemlsbGE+AEFwcGxpY2F0aW9ucy9TeXN0ZW0AcnRjdGwuc3lzY29u
ZmlnAHJ0Z3JvdXBzLjUAcnRjdGwuMQBydGN0bC5pbml0AHJ0Z3JvdXBzAHJ0Y3RsAGxpbnV4AG5v
YXJjaAAAAAAAAAxsAAAMuAAABSwAAA5AAAACewAABMMAAAlqge2BpIGkgaSBpIGkgaQAAAAAAAAA
AAAAAAAAAEidoWNGN381SosDiUqLCSBKiwixSor4SEidoWM4NjIzYTU4MzBmMjJlNzIxZTI4ODM5
NTIzZjUxNzc2ZAA4YmI3MDQ0Y2MyMjRhMjc4NjcxNTE1ZTVhNzZkYzgzYQBkOTFkZDYwM2Q2N2Vk
MmM0ZWI1ZWMwODZhOTk4NzhlNwBjZjNhMDJhMDhiNTU2ZmQ5M2E0NzRlYmM3Yjc1ZWJiYQBhZjYw
NDJjNThhNWFjNDM5ODJiYTk0YWZhMGRjZThhZQA2OWI0NmFkYTAzOGY1MWMzOWJhYzBkZjMwYjJh
MjUzYwA2MTdlZGM1Mzg1Yjc5MjQzOGQ5NDVkOWVlMTcwYmFiMQAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAgAAAAAAAAAAAAAAAAbW9ja2J1aWxkAG1vY2tidWlsZABtb2NrYnVpbGQAbW9ja2J1aWxk
AG1vY2tidWlsZABtb2NrYnVpbGQAbW9ja2J1aWxkAG1vY2tidWlsZABtb2NrYnVpbGQAbW9ja2J1
aWxkAG1vY2tidWlsZABtb2NrYnVpbGQAbW9ja2J1aWxkAG1vY2tidWlsZAD/////////////////
////////////////////AQAASnJwbWxpYihDb21wcmVzc2VkRmlsZU5hbWVzKQAzLjAuNC0xADQu
NC4yLjMASoskYEqLJGBInhNgSIj7YEgoveBIF5pgSA+xYEf+jeBH/o3gRldcYEY3uGBGJUNgQ2xh
cmsgV2lsbGlhbXMgPHdpbGxpYW1zQHJlZGhhdC5jb20+IDEuNy0xAENsYXJrIFdpbGxpYW1zIDx3
aWxsaWFtc0ByZWRoYXQuY29tPiAxLjYtMQBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gPGFjbWVA
cmVkaGF0LmNvbT4gMS41LTEAQ2xhcmsgV2lsbGlhbXMgPHdpbGxpYW1zQHJlZGhhdC5jb20+IDEu
NC0xAEx1aXMgQ2xhdWRpbyBSLiBHb25jYWx2ZXMgPGxnb25jYWx2QHJlZGhhdC5jb20+IDEuMy0z
AEx1aXMgQ2xhdWRpbyBSLiBHb25jYWx2ZXMgPGxnb25jYWx2QHJlZGhhdC5jb20+IDEuMy0yAENs
YXJrIFdpbGxpYW1zIDx3aWxsaWFtc0ByZWRoYXQuY29tPiAxLjMtMQBDbGFyayBXaWxsaWFtcyA8
d2lsbGlhbXNAcmVkaGF0LmNvbT4gMS4yLTIATHVpcyBDbGF1ZGlvIFIuIEdvbmNhbHZlcyA8bGdv
bmNhbHZAcmVkaGF0LmNvbT4gMS4yLTEATWFyayBTYWx0ZXIgPG1zYWx0ZXJAcmVkaGF0LmNvbT4g
LSAxLjEtMgBNYXJrIFNhbHRlciA8bXNhbHRlckByZWRoYXQuY29tPiAtIDEuMS0xAENsYXJrIFdp
bGxpYW1zIDx3aWxsaWFtc0ByZWRoYXQuY29tPiAtIDEuMC0xAC0gYWRkIC9ldGMvc3lzY29uZmln
L3J0Y3RsIGZvciBjb25maWcgcGFyYW1ldGVycwotIGFkZCBjaGVjayBmb3IgY3B1c3BlZWQgdG8g
aW5pdCBzY3JpcHQKLSByZXdyaXRlIG9mIGluaXRzY3JpcHQgbG9naWMgZm9yIHNlcnZpY2UgY2hl
Y2tzAC0gY2hhbmdlZCBORlMga3RocmVhZCBwcmlvcyB0byBiZSBiZWxvdyBzaXJxIHByaW9yaXRp
ZXMKLSBjaGFuZ2VkIGluaXQgc2NyaXB0IHRvIHVzZSBzeXN0ZW0gZnVuY3Rpb25zAC0gQWRkZWQg
c3VwcG9ydCBmb3IgU01QIGFmZmluaXRpZXMKLSBvbGRlciBmaWxlcyBjb250aW51ZSB0byB3b3Jr
IGFzc3VtaW5nICcqJyBmb3IgYWZmaW5pdHkALSByZXdvcmtlZCBwcmlvcml0aWVzIGluIC9ldGMv
cnRncm91cHMgKEJaIDQzMjcxOCkKLSBmaXhlZCBhc3N1bXB0aW9uIHRoYXQgaXJxYmFsYW5jZSBp
cyBhbHdheXMgaW5zdGFsbGVkIGluIHJ0Y3RsLmluaXQALSBjaGVjayBpZiBpcnFiYWxhbmNlIGlz
IHJ1bm5pbmcsIHN0b3AgaWYgYW5kIGRpc2FibGUgaXQgKGNoa2NvbmZpZyBvZmYpCi0gaW1wbGVt
ZW50IElCTSByZXF1ZXN0IG9mIGxvd2VyaW5nIHJ0cHJpb3Mgb2Ygc29mdGlycSBhbmQgc29mdGly
cS1yY3UgZnJvbSA1MAogIHRvIDMwAC0gZml4ZWQgdXBncmFkZSBsb2dpYyAtIG5vdyBydGN0bCBp
cyBlbmFibGVkIGFmdGVyIGFuIHVwZGF0ZQAtIGJhY2tlZCBvdXQga2pvdXJuYWxkIGVudHJ5IGlu
IHJ0Z3JvdXBzIChsZWF2ZSBhcyBkZWZhdWx0IGZvciBub3cpAC0gcmVtb3ZlZCBwb3NpeF9jcHVf
dGltZXIKLSBmaXhlZCByZWdleHMgZm9yIHNvZnRpcnEtbmV0LVtydF14IGFuZCBoYXJkaXJxCi0g
YWRkZWQgJyonIHNjaGVkdWxlciB0eXBlIGZvciAiZG9uJ3QgY2hhbmdlIHRoaXMgdGhyZWFkJ3Mg
cG9saWN5IgotIGJyb3VnaHQgYmFjayBrdGhyZWFkIGdyb3VwIHdpdGggJyonIHBvbGljeQAtIGxl
YXZlIGt0aHJlYWRzIHdpdGggZGVmYXVsdCBzY2hlZCBwb2xpY3kgYW5kIHByaW9yaXR5Ci0gY29t
bWVudGVkIG91dCBrdGhyZWFkcyBhbmQga3JjdXByZWVtcHRkIGxpbmVzCi0ga2pvdXJuYWxkIGlz
IG5vdyBTQ0hFRF9GSUZPIHJ0cHJpbyAxICh0ZXN0aW5nKQotIGFkZGVkIHN1cHBvcnQgZm9yIElS
US0gYW5kIElSUV8gaGFyZCBJUlEgbmFtaW5nCi0gYWRkZWQgc3VwcG9ydCB0byBzb2Z0aXJxIGFu
ZCBzaXJxIG5hbWluZyBjb252ZW50aW9uCi0gZGVjcmVhc2VkIGJ5IDEwIHJ0cHJpbyBmb3Iga3Ro
cmVhZHMgd2l0aCBwcmlvcyBiZXR0d2VuIDkwIGFuZCA5OAAtIHVwZGF0ZWQgcnRncm91cHMALSB1
cGRhdGVkIG1hbiBwYWdlCi0gYWRkZWQgYXdrIGNvZGUgaW4gZG9fc2hvdygpIGZvciBwZXJmb3Jt
YW5jZQAtIGluaXRhbCBwYWNrYWdpbmcAbm9hcmNoAHg4Ni0wMDQuYnVpbGQuYm9zLnJlZGhhdC5j
b20gMTI1MDYyNTkxNQAAAAAJAQAACQEAAAkBAAAJAQAACQEAAAkBAAAJAQFlgaoBZYGrAWWBrAFl
ga0BZYGuAWWBrwFlgbAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABydGN0bABy
dGN0bC4xAHJ0Y3RsLmluaXQAcnRjdGwuc3BlYwBydGN0bC5zeXNjb25maWcAcnRncm91cHMAcnRn
cm91cHMuNQAAY3BpbwBnemlwADkAAAAAAAAAAAAAAD8AAAAH///9EAAAABAfiwgAAAAAAAAD7Vvr
V9tIss9X66+oEWaCE2xsAwEMya4hJPE9AXxtuHOywHJkqWVrkSWvWoIwgf/9VlW3XuYRmLnz5Z71
SYzUz+rqevyqut3caG40W83Wu/XNlmU18bPZEk7z4U9rbXPLsVrvVvnNfmfr8q20/pF+79KHKLZj
/9XCLysjL1gZWXJiGIm0xgKWasYPA/Aj7EkI5gkVdqDahNN63fV8ATv0HVhT8eEcpIhhZxyFyYwL
YGcWeeEHauKGtyMrtie3UXQbxhMRfTALo4L6PDJqJGjc08LA58/vLCfhdYmm052ZvHCncTbIdy+G
lnFnGIPjz4Ojk/6n3tf99ysitleimPtJw7akALPaMsELgHupmWpgVIq9zGrb3DYqcuK58TaoP0Zl
e9sQ0rKNU6i7OMqPQo87E87h9haKLC436AAvKQhjcMMkcOaJPoXqAtR9fMORfv0VeNeMvYOP76st
gykwDB7tsHuABJqGsWAsAO5LEAPuA/R7HyWELpaEtpBSSBgJPwzGXjCGOITqj6zzHVgSHOF6gXBw
COREmdIGjsz8uph5jkwFZyahLkLAomV76sAtWNeX8JoXsfLPU6v+e7f+j4tmfat+/rZz+iaMRu55
5xTf8bXxtrqiOQMgZ74XL1WbyzCzolgug9kxa6ArPReWuPi0dQ7v30O23TXsXwEIooso8XFtb98j
17AgEmPxfXYRui6J1ntAcRnHk2yMGrwtF7XvF61y0RqNRtMX62rwAdb01PNzvZ2bbI2HYaLu6Etx
UPWRpynhuCqQyUjGEbGgNGJN8+DOyL9X/glvFBOhxEQ3jGDJw7Fa2+DBzvuMMdvw9q3HFNNapqSp
S9X28hw13nmtlo1FHyVGVaZ+FAnrMqu7K1P1Ot+S9yWRKosQ1EmkDVzVhZoZxc1K/PgvlCY7DFwl
TAVZyoglYTJN0lBq95B0pQsui1haqlYh7YlwSnvJo7XP59qRtbzfbPXcqDwir5qogmzqgedLMmEt
iCpV1GAH1rWkKhosFxXci29KdJhvTKNyB8JHM/jjvv68LRNUEOknxtRNcdw5LvzVsp/LvAcfWBXq
9WfLfqUgIHpfvXP4hVlU1o1UO0x7EsVQn0HdhLluJpjFndcl1dwY5FNlLPzZbLElL2lPcEIT7vdV
E+DXB1hxxNVKkPi+qebLh/q/UWXUToQRpM/kcdgPmzNpQpjEsyTm/eCRyPvEE5zSkdjSCS+4aYY7
lLcmb0ZvS5C7mO3UHFRVG6jNGwQWg4IMUK/TKmmx1tGnRYbYj8xCT0cdiwzXhq+ZFTjCF7HIJphn
Gds1ZgNuDW12hPsBVuAACwOKYwSz0Pfsm6f4gn0zthQ87S1cTwgjUFOigOudUNOQil+1TRtfzesD
QURpaIOAgcANV5k4UWYOARTCCASsFhFGWptjC5Lb/qB39L7aNirDvS/7CEFWjYqeYJWHZ4dIaLBm
VHQbs+6iABJI4koGh8XasFgblaqiYhXDy2LtqFj7hmoU5aqQEVlFc7VKdEOVezJeU3xg4HmPE+M5
rJXWorRkrGrC+TbBq6CkoiVepYWulz3e93sFYkgr7tEyj/sq5e3Q+C/dg4V8D1rEj1TXqGnGqWax
xiRPG8UksctKPsnvPoOx+JTW6soUBRuMXZtGsxjfjFR8Y609Gt+8W93YcFfXVXwz2nxmfLNZim8a
rVevXjXOTOC3pVYNplYwI+qwkP7DXji7ibzxBBVtrwbtZnMDBsKBL1a8DL3AbmQNjyeeBPznRkKg
LtnJVASxFXthsA03YQK2FaA+Oh56LW+UoGXANaO6r4QRd5+GjufeUCFCetR9QuKxiKZSKb2Az4cn
8FkEIrJ86Ccj5Dx89WwR4D5akoeYUalE4wGjG+7yiUgZhm58bUX4RsGCJkh4pFRwJSKJ79DGSXgI
6qVHLa7sqdlfS1yWKyIRYLRAAYIZjv4l7BjduSPUAGTVTPFd2ElsjdDPYgnSg01HyIUAVzmL0FQ6
FE0QAdod4Lqt4IYHSNlJphDdcUyhCBrF+GZG+siv8kbGYrqM49l+4mAJd+TRp8h1CxlOZLCZxqnU
HHO7h3uf4PrwKd8mh4w9UTUJZ0jzxIppj6493yfqEyncxF/mIbA1/NY7/nJ0cgzdw2/wW3cw6B4e
f9vG1vEEJwRxJdRY3hTRJg6N+xJZAdp9zf6D/cHeF+zT3e197R1/ozV+6h0f7g+H8OloAF3odwfH
vb2Tr90B9E8G/aPhfgNgKIgwFtmnpITcyDRExjsitjxf5ov/huKJyp34DkysK3IbtvCuaENwE2c3
j0sg986kkIJEXiu2zri5TVYQY9VluEYPx7ueiib3fkA8lWItw/oWHAvkFIakvmWLZRgmNMLqKoL0
3VDG1PKgC812q9VSW3Ay7OarIl2tN9fq7SYcWNElDC0fhQF2ppIf/o7KiLvZsMPpB25Pnx6iIg+X
pxVDjXX8BQbHe8dfwcRw3+zOIhoavZepPHWMvMSXr16QfIcTKSLUiANeO/YdfgGyvQbbFzirE1e8
WeKTPKJ39uuxhzEFirSSNpk7+3IMziMNvx0e9Ye9oR7t9MzdVVmHM3cAZ24vTXLg6zm+76Ju6JoM
oOl3Mt/6kReBz0ZjFD13YHaDDwz9kjHImzxE3SmRJ+uI3qglr/vj/nBv0Osf944OjUa/bzR2B8pg
A1psig0laQoNqAxIzliNpchAzPHYyiFVxuQG9DN+k0hyC1SDOBwLtpdoVzkGzNMeZB0sjly8cRKx
+HJ6poESioqgEZy2PIzxDHIEaDoIZVA5mr7IQ8vgNHitR7zMIUodrVNnlQw5E7bnekj7w5N9VOiA
TFcpT9VIx8lYXBiKWKWZEBWyPaihaOoiktAwaLD1V62ou2TTXVg8GZ4HKErnpVXPTalnyhiSteXN
mmtc2EDNyyWEqWwvUQgIN6IADZZQZhiqXXzqfTrCgtqyEpKoXDsY5HWMDsvVu93jvS/cAsgrYyPG
nuVGR8df9nmYfI0srXOEK0+Vms50zeiflfNSLk77aQZWaIfQNjiNFEgYXEPSpodCX5N5dgpzaJuI
4Upu0PR93meKjkOWrQetC/nUBwS/8xdZFEWNyta+hB6SQQ144crykxdQ+Lhp0qwhXt/bjj/Llufb
sv7+4KA3HLKOd2lP0SknEkPAkGaULHV73f7F8Nvw4rC3t28gK+yJFYzFvD7Ms1GTjYCgG9yokRXm
VPaFNbXQ3QuUXGUS1D1B7DIwfkOdjBGnoKQV3KZqYg72+0eIQA4/w+7J56FpDMQsxGBylIx5zx7y
rarn3lH/26D3+cuxkQPqsyU7fBBRoxMpoWmpMcI2CrZmQ5hEtoI0hFBoPWiEHI9WQxxAo4VmCvsf
HhkpyNrmlDljMOr3R7CWYsJwfx+6X4dHJm8WR9Pkh+gF9TJ9TE0wLK1jgZwZQ0I8WMF7QEFmHugv
tWuGckqOkHbksV6ntkMBi8LO0eMUTWwpXrJ/Gi9Zm6Pm6qaKj9bbzz0PGpXjJUobYciUngvJSZrD
uLhUmQlOXFV4+zAUQZSs1gOxdYmCapP3wHXJ2IpY81bwMZzN6JFHsieXypt0oL26tg5bW9BqYnmB
Lx0EvPG8o88yKDj4pYgC4RcyJdgfHTga3Ug7T1Qz5ScxalAlK7w8Az/IXPsSltLcDqrRFQLcND5X
JzYriYxWJDGgquv1qQ0qWxIFoLJACHxVI90G0sa0/DihNI0YR2IGZpQEAbLgFo0KxkeOCR+yVBy0
P/za0pmDSml4nSbQZXz0g2ELDfAo9Uw3UeSH4zHKXT1OkS2NQZuQkRi6rjpYenQJ4axQn+1baQTO
cS0QI7zo3yPLtzBGJK3U62X8Q/vIxsoJhQxeY2yFyooxFnXklXnkRV3CXPg0tW5gkqDGYRCDkR2K
o5wSDBkcGwZOozYvn6yQcuFkjFntDf57t/u1e7i3b1Iam5aZZWYqKf/yAVJO4z+9EnuWoKcn8POT
dYjvGOTZKJP+Da3p0SVxLDm/psJq0gnvr2WvfzLs7+9/fGIlaefiOrTsR3bDWSF9xj9uEthsO43S
yaaSIdLVW/Sr+q8fWg5lnSp8OFkPoGoOdRBe0rxUJxERdcBE4WVfyv7ZqMjEJmdl8CD4TRmg6t+y
LBFJV22+FVWols3tQktSJZUF01Owi9fmSKqTIV+mOSt76tyf7o3uzyuqFo60fzy0+Fui7lZNfOsI
dH53ph6ztX0/rVW2086z7PRWW72JrNkL7TSBUbLTh4hEOhXFGON/VFTbqbQaG+i6fYFbjS+LP/5G
+Y47Y5ggBI1uOpUh21qp/WsQR6GfeZ4UjWeby/acsy+Zyf1Mng+n7c5IBRhjyJUhtzF0uqBT+dz/
auwmnu90I3vSqQShhX+NIXv2ZkeTrF5b9KpP3lVJWzdgh6TLVtOyli5Yy7s11nXZetooM/2KiEEY
xp3K4o+LeDqbWfHkbmXxB8G4u/riD50NoMdIce2uHmH7+uISdrjwnIvkDhWhZhyNZEhZf9mpzLtE
OlttNZpIG8aYV57zUBvDWCz4OQ0+PYr5CEATm/W+cCiAeKuQTJgPlorbY+QJhfJGNXDGGXogYxEn
QPBbt6F+bNgzWPwxPDoZ7O0376BRfG/Nvbfn3lfn3tfm3tfp3VgcEceN8e/eDPSOQWGjjEUvQO3y
fSOaQj1yoTroH1zsnvS+YgR3dHRs6Gqof4T6FDbW13U2YK5d7qWVLJW7vVtbyzHafM/SXY9HpmPR
e7hnwbI+PjWvuzH+/WGyJ4iUVnB/6X9rJW/9xCoa688abX2l1OHR5WUK8uAa55AT4K7ZqBrBY3tm
LFLQJEnCXYpclurLpELqq14zFrmwidMvA5fxdw3mN3FRzboUhCi3lBaslTMejzaYh3qP7NRPuP9z
dqJGhTI25mGR4hJqNWtcEhjah7fYeTcJPyrfDQuQBKkCPDIKIity5IsqMEQwZ7yB40RANxlDa5Ni
qi3Y8yl6+w3BhWdNJexc66dibIYWaaPeMupgOc6DXEo9AM09syK0h4hQpO6g4Am3SDER2iTWCmWo
sF0kVNoXTQ9V6GAAKfZs7pmCRR4L0ccfXsc7XodiiAOHn4YpAmBTKPVpA91kugaJ+K5gIQv9CsRT
D7SzqcUsIKQ3GBPHTCNsEY2b0I0Cy3dC2LOiK8ufUPICDnAq2LHsqZijdJ0p7ToOzieTGQfQxIrh
QR/0wbwiKvTpIIjVhr0wxoGcP78OkSGWlMmULP3rN69VQlOf6TMPJwn8V4Kxw5qi75k8XGPKcMtw
AlHEb4SwS1oGS7v/gLXV9kZrs4ZdXO87H98gSSp0VeckJcxv+dfWDY3Ekq2ShwUXjlQfYMcDxPet
tqL6a4LdkPTEQfc5aMDnMLAt/wrJ2fHH6nluAav1Vd5MDgIeCTqWGVxSNaH2DPFjDJ+rGSoYLYuO
aQSfO/V2D5Av/04QB5IooxCJiJivQKXyrKEbk1zxEb56rkd2Am4UTmGdQjbcutVmuj18jLD1xxfa
ztiezMaRhQKnlKoOAUp4Bh10RInSQWcfGIUkMwfhAlHxGxYzFasvEpJVFpKRZV+qYzS4/BcCK5J/
nCyObtS+pmKCLuEqzZdzOo9EFSmsFfnQar6IgjYvPhLTkM6o0Np63y/QAl1QIiDK2MLXdBSETbcj
EHH9NIrPv/MmoRF3sFQZM+xAipSnZOhskTubTkjRXJaD86RGT6+lTkmbxA9cL+W0iC+Z5VEZRT4R
o8FV64cW/nIBaPMuKO5moQ7PlDKal/LgAUSdc80iPQfN+1OrS5RZdFACFdkBhJJsifItRjpJvvJk
u1YBaMES4l6KAmsZR4vWDePuOk+ADxfMe3qiMwU6q53vgapS0id6UE3JEl4h7QSQ67hYOyI8zolx
5KYmhiYsc0Wp6Qjj1Gt0sVtNHnZrkzbjU+Sx2Wmvq2Tkzw4LUcVajRbLoFImJ5P31H/RcM3Wi4Zr
FYZDVAF8CSFlC11houN00i19EWOpxquciYjTuJSqSJ0nCdaGmvxZGkUENJkAssSWj3Pblxbd952L
XcWzYtfNkYpR2xuj58WuefEc8KQ8o7EAhTiIDlspy4fbiZGq56vLUZQG5Cygyj/IZfY/2BMdDZ0J
WioxQ0LFZzQ3JWygXRwJRMH9LqAqk1yFQR5+oUnBYCuizE4kJIWEpXPAMg5dUNe70hzN+x9hcIt+
5Q7LKFbLINMYrVhA/julNQ3RkFrS7hn5GrD4bjb2xbn5tB3JKaSL8hNAZaBCzi/JUPNOo6sFBRRy
tydzMq4RegoMdMkToqeURkY4oU1eSp46m19MwdGmgA7hPNkQqbjOzOaWdCEjShgDWnRp3LKjUBI6
8MG6sjw/y1rpg7BEJlh3wyAUTVms9TkmjDymJU3J96H2W86UsEVkxWEkadvuS4XMT5XytdASmF1G
YX30+qok++4zZN9yN9fU/aI1e/WZeZutXPaV4CiZ70oZ2nxrJT8UQ96FfAjrpDcESga/dImQkvLz
R6cN3sVP6jTRk53ijyA6O9wc//IPNDopmuzssB/9wF3zS9B8ZMU5MZLMkUBjEeiDNPIZjXR61XBE
J8kksh147b6GJXXdbwEe/rweYRN9d+/RNhG2iejGSD0KMUR6omWILdUVQni8EXrnFKr4SCoNl3JA
GZ6J+A5BMh2JaFkdQqlLtXRjjHRKX6kBa0QOVTUkZqASyeUnp51izCzBLExukskjpvPMARt/fuc9
OOZjD13LV5PJP4wtkv3sXFOf1MvsuhPqh6mvxtJtPSUJdEw49ug8rNiPU+w8sLothKY04O3j3c8N
TQYnFoq3VgsH9XzHy7qk4zaCwKT9viVjNTaDZ75I3YBhqG0bzzfWN4y0iOt7SShCHMzTk0vNuK0+
crchve2wAIaROv7Om04L/5+dNt6cnVeNa5rWCccdt7O1xeVpCdUbU2+s7i/k9VnR2Qo30YgEG2w0
9cBLuuyWEEqt2IrBZvydGq9z43JTXX2vR/R0j6jcg5mOHVoPtVfH8Ir0aGZ7IbV8p4ZW71zlh/Zl
oYZfuSJwZaGc3rhYw2as2dRk0pRoO2unZ/WLlXNuVLKdCgY8aTuLv1Xbeme9POedZmBeZfc5VcnS
+n+udP7nSud/rnT+P7vSufGnrnRy0F2nf1svSN1lI35MRTeDCK4nfKdwWZTv3A9hHcwtyhMSBqIp
X3plVLvAug4yytjv3u3Q4i3JM7dXikbO3L5GE93hXq+nfkF6PfHsiR5bPjG4Pt32ogxq/uSCZSO/
f0PAQaWFMFI1CBsus9IKC6emVxTP4oW5Dl+VaQyG+oejRFVHuTkCHDkuVeABW+5zDzJovAvFmyJ8
WRFH7PUhH43v1THQ0TqgcA23UjcQFVYFZOKuS7e4lvJsR22ZSqNC6YBuC1LhqFDIFwnVLUKsCQs1
fHuwpmbjIz+mBsUp8myKvO/fjez189QuGy3xHSMeG+PfvHkhdXzDPTR3FHokkHo/dM1YZ3SzcbQN
ZK1Hrc6ZRhofp8hzpnEn75tRwo5PQc77cPOlSPPP40yax/hTCJMlraz4aPMl3y0j1pJdQPcirAjd
QeaOWaM4Fl/mxHRseDL/BTcHAqSelEAXDjZpiEbp3mhxg3Fh8jLdKsMXbqzihmWEGfocA8kki0B3
9J5/RY9+pDc0ykmMB+675RevDeNVivOe93luu0dx3vGgi0QOfvnlF8J5/wtedGaGEEEAAP==


--=-9o40/M3tjYTdN/huUaSj--

