From: "Remy Bohmer" <linux@bohmer.net>
Subject: Compile bug in 2.6.24.8-rt7 on ARM
Date: Tue, 20 May 2008 22:37:34 +0200
Message-ID: <3efb10970805201337g2212835bl9ca26a3031141ce2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2645_8624103.1211315854875"
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765665AbYETUhv@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

------=_Part_2645_8624103.1211315854875
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Steven,

Now I started looking at compiling 2.6.24.7-rt8 for ARM, and I found
another compile problem... ;-))

This one:
 CC      arch/arm/kernel/process.o
arch/arm/kernel/process.c: In function 'cpu_idle':
arch/arm/kernel/process.c:175: error: implicit declaration of function
'trace_preempt_exit_idle'
arch/arm/kernel/process.c:180: error: implicit declaration of function
'trace_preempt_enter_idle'

These function do not appear to exist _anywhere_ in the kernel.
So these calls can safely be removed, I guess.

The offending patch can be found in the broken-out set under the name
arm-trace-preempt-idle.patch.
Attached you can find a fix for it (I expect that you will not need it)


Kind Regards,

Remy

------=_Part_2645_8624103.1211315854875
Content-Type: text/x-patch; name=fix-compile-error-trace-preempt.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fggy4u4u
Content-Disposition: attachment;
 filename=fix-compile-error-trace-preempt.patch

VGhpcyBwYXRjaCBmaXhlcyB0aGlzIGNvbXBpbGUgZXJyb3IgaW4gMi42LjI0LjctcnQ4OgogQ0Mg
ICAgICBhcmNoL2FybS9rZXJuZWwvcHJvY2Vzcy5vCmFyY2gvYXJtL2tlcm5lbC9wcm9jZXNzLmM6
IEluIGZ1bmN0aW9uICdjcHVfaWRsZSc6CmFyY2gvYXJtL2tlcm5lbC9wcm9jZXNzLmM6MTc1OiBl
cnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ3RyYWNlX3ByZWVtcHRfZXhp
dF9pZGxlJwphcmNoL2FybS9rZXJuZWwvcHJvY2Vzcy5jOjE4MDogZXJyb3I6IGltcGxpY2l0IGRl
Y2xhcmF0aW9uIG9mIGZ1bmN0aW9uICd0cmFjZV9wcmVlbXB0X2VudGVyX2lkbGUnCgpTaWduZWQt
b2ZmLWJ5OiBSZW15IEJvaG1lciA8bGludXhAYm9obWVyLm5ldD4KLS0tCiBhcmNoL2FybS9rZXJu
ZWwvcHJvY2Vzcy5jIHwgICAgMiAtLQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpJ
bmRleDogbGludXgtMi42LjI0L2FyY2gvYXJtL2tlcm5lbC9wcm9jZXNzLmMKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQot
LS0gbGludXgtMi42LjI0Lm9yaWcvYXJjaC9hcm0va2VybmVsL3Byb2Nlc3MuYwkyMDA4LTA1LTIw
IDIyOjA2OjMzLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjI0L2FyY2gvYXJtL2tlcm5l
bC9wcm9jZXNzLmMJMjAwOC0wNS0yMCAyMjozMDozNy4wMDAwMDAwMDAgKzAyMDAKQEAgLTE3Miwx
MiArMTcyLDEwIEBAIHZvaWQgY3B1X2lkbGUodm9pZCkKIAkJCWlkbGUoKTsKIAkJbGVkc19ldmVu
dChsZWRfaWRsZV9lbmQpOwogCQlsb2NhbF9pcnFfZGlzYWJsZSgpOwotCQl0cmFjZV9wcmVlbXB0
X2V4aXRfaWRsZSgpOwogCQl0aWNrX25vaHpfcmVzdGFydF9zY2hlZF90aWNrKCk7CiAJCV9fcHJl
ZW1wdF9lbmFibGVfbm9fcmVzY2hlZCgpOwogCQlfX3NjaGVkdWxlKCk7CiAJCXByZWVtcHRfZGlz
YWJsZSgpOwotCQl0cmFjZV9wcmVlbXB0X2VudGVyX2lkbGUoKTsKIAkJbG9jYWxfaXJxX2VuYWJs
ZSgpOwogCX0KIH0K
------=_Part_2645_8624103.1211315854875--
