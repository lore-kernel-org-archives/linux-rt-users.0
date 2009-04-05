From: GeunSik Lim <leemgs1@gmail.com>
Subject: cyclictest - fix comparison about flexible word counts of
	available_tracers file.
Date: Sun, 5 Apr 2009 15:45:33 +0900
Message-ID: <49b7c2350904042345x574edfcbx553ba1caccb8bd06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd32c48f0ec170466c92088
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:54710 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbZDEGpf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Apr 2009 02:45:35 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1761943rvb.1
        for <linux-rt-users@vger.kernel.org>; Sat, 04 Apr 2009 23:45:34 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--000e0cd32c48f0ec170466c92088
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Thomas,

I found bug at settracer function of cyclictest.c source (rt-test ver 0.33).
settracer func use 10 times in the for() statement to searching tracer
like preemptoff , irqsoff , preemptirqsoff.
But, I think that we have to consider 10+ words in the available_tracers file.

[root@fedora9 tracing]# cd /debug/tracing/
[root@fedora9 tracing]# cat available_tracers
syscall blk kmemtrace power branch function_graph mmiotrace wakeup_rt
wakeup preemptirqsoff preemptoff irqsoff function sched_switch
initcall nop
[root@fedora9 tracing]# cat available_tracers  | wc -w
16
[root@fedora9 tracing]#
[root@fedora9 tracing]# git clone
git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
[root@fedora9 tracing]# cd rt-tests
[root@fedora9 tracing]# make clean ; make all
[root@fedora9 tracing]# ./cyclictest  -n -t 3 -b 1000000 -P-D 2 --> Success
[root@fedora9 tracing]#./cyclictest  -n -t 3 -b 1000000 -I -D 2  --> Failed
[root@fedora9 tracing]#./cyclictest  -n -t 3 -b 1000000 -B-D 2 --> Failed


So I made  patch file to consider above case.
If I mistake, correct me.

--------------------------------------------------
[root@fedora9 cyclictest]# diff -urN ./cyclictest.c.ori  ./cyclictest.c
--- ./cyclictest.c.ori	2009-04-05 23:48:03.000000000 +0900
+++ ./cyclictest.c	2009-04-06 00:15:51.000000000 +0900
@@ -320,7 +320,7 @@
 	char name[100];
 	FILE *fp;
 	int ret;
-	int i;
+	//int i;

 	/* Make sure tracer is available */
 	strncpy(filename, debugfileprefix, sizeof(filename));
@@ -330,7 +330,7 @@
 	if (!fp)
 		return -1;

-	for (i = 0; i < 10; i++) {
+	while(1) {
 		ret = fscanf(fp, "%99s", name);
 		if (!ret) {
 			ret = -1;


--------------------------------------------------

After patching .....

[root@fedora9 tracing]#./cyclictest  -n -t 3 -b 1000000 -I -D 2
[root@fedora9 tracing]# cat trace
# tracer: irqsoff
#
# irqsoff latency trace v1.1.5 on 2.6.29.1-rt4.20090403-ftrace-lgs
# --------------------------------------------------------------------
# latency: 108 us, #3/3, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:2)
#    -----------------
#    | task: swapper-0 (uid:0 nice:0 policy:0 rt_prio:0)
#    -----------------
#
#                  _------=> CPU#
#                 / _-----=> irqs-off
#                | / _----=> need-resched
#                || / _---=> hardirq/softirq
#                ||| / _--=> preempt-depth
#                |||| /
#                |||||     delay
#  cmd     pid   ||||| time  |   caller
#     \   /      |||||   \   |   /
  <idle>-0       0d..1    3us!: acpi_idle_do_entry <-acpi_idle_enter_bm
  <idle>-0       0.N.1  107us+: cpu_idle <-rest_init
  <idle>-0       0.N.1  110us : trace_preempt_on <-rest_init


-- 
Regards,
GeunSik Lim
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--000e0cd32c48f0ec170466c92088
Content-Type: application/octet-stream;
	name="fix-comparison-wordcount-available-tracers.patch"
Content-Disposition: attachment;
	filename="fix-comparison-wordcount-available-tracers.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ft5wjoal0

LS0tIC4vY3ljbGljdGVzdC5jLm9yaQkyMDA5LTA0LTA1IDIzOjQ4OjAzLjAwMDAwMDAwMCArMDkw
MAorKysgLi9jeWNsaWN0ZXN0LmMJMjAwOS0wNC0wNiAwMDoxNTo1MS4wMDAwMDAwMDAgKzA5MDAK
QEAgLTMyMCw3ICszMjAsNyBAQAogCWNoYXIgbmFtZVsxMDBdOwogCUZJTEUgKmZwOwogCWludCBy
ZXQ7Ci0JaW50IGk7CisJLy9pbnQgaTsKIAogCS8qIE1ha2Ugc3VyZSB0cmFjZXIgaXMgYXZhaWxh
YmxlICovCiAJc3RybmNweShmaWxlbmFtZSwgZGVidWdmaWxlcHJlZml4LCBzaXplb2YoZmlsZW5h
bWUpKTsKQEAgLTMzMCw3ICszMzAsNyBAQAogCWlmICghZnApCiAJCXJldHVybiAtMTsKIAotCWZv
ciAoaSA9IDA7IGkgPCAxMDsgaSsrKSB7CisJd2hpbGUoMSkgewogCQlyZXQgPSBmc2NhbmYoZnAs
ICIlOTlzIiwgbmFtZSk7CiAJCWlmICghcmV0KSB7CiAJCQlyZXQgPSAtMTsK
--000e0cd32c48f0ec170466c92088--
