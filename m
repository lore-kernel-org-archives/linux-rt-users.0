From: GeunSik Lim <leemgs1@gmail.com>
Subject: cyclictest - duplicate explanation of cyclictest option
Date: Mon, 6 Apr 2009 11:56:46 +0900
Message-ID: <49b7c2350904051956n214efbb5pc8cd9990820a534f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd331de8f1a2e0466da0c27
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:52105 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbZDFC4s (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Apr 2009 22:56:48 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1991267rvb.1
        for <linux-rt-users@vger.kernel.org>; Sun, 05 Apr 2009 19:56:46 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--000e0cd331de8f1a2e0466da0c27
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Clark,

This is trivial contents about option of cyclictest.

Cyclictest utiltiy (ver 0.34) display the information with duplicate
"-h" options,
when a user run "cyclictest --help" command.
User will confuse  exact understanding because of duplicate
description of -h option.
How about you remove "-h H_MAX  *****" line?
Thanks reading.

Signed-off-by: GeunSik Lim <leemgs1@gmail.com>

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index f878217..cedc36f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -688,7 +688,8 @@ static void display_help(void)
               "-d DIST  --distance=DIST   distance of thread
intervals in us default=500\n"
               "-E       --event           event tracing (used with -b)\n"
               "-f       --ftrace          function trace (when -b is active)\n"
-              "-h H_MAX                   latency histogram size in
us default 0 (off)\n"
+              "-h       --histogram=US    dump a latency histogram to
stdout after the run\n"
+              "                           US is the max time to be be
tracked in microseconds\n"
               "-i INTV  --interval=INTV   base interval of thread in
us default=1000\n"
               "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
               "-l LOOPS --loops=LOOPS     number of loops:
default=0(endless)\n"
@@ -710,8 +711,6 @@ static void display_help(void)
               "-D       --duration=t      specify a length for the test run\n"
               "                           default is in seconds, but
'm', 'h', or 'd' maybe added\n"
               "                           to modify value to minutes,
hours or days\n"
-              "-h       --histogram=US    dump a latency histogram to
stdout after the run\n"
-              "                           US is the max time to be be
tracked in microseconds\n"
                );
        exit(0);
 }


-- 
Regards,
GeunSik Lim
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--000e0cd331de8f1a2e0466da0c27
Content-Type: application/octet-stream;
	name="remove-duplicate-h-option.patch"
Content-Disposition: attachment; filename="remove-duplicate-h-option.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ft6kesce0

CkZyb206IEdldW5TaWsgTGltIDxsZWVtZ3MxQGdtYWlsLmNvbT4KQ3ljbGljdGVzdCB1dGlsdGl5
IGRpc3BsYXkgdGhlIGluZm9ybWF0aW9uIHdpdGggZHVwbGljYXRlICItaCIgb3B0aW9ucywKd2hl
biBhIHVzZXIgcnVuICJjeWNsaWN0ZXN0IC0taGVscCIgY29tbWFuZC4KVXNlciB3aWxsIGNvbmZ1
c2UgIGV4YWN0IHVuZGVyc3RhbmRpbmcgYmVjYXVzZSBvZiBkdXBsaWNhdGUgZGVzY3JpcHRpb24g
b2YgLWggb3B0aW9uIAoKClNpZ25lZC1vZmYtYnk6IEdldW5TaWsgTGltIDxsZWVtZ3MxQGdtYWls
LmNvbT4KCmRpZmYgLS1naXQgYS9zcmMvY3ljbGljdGVzdC9jeWNsaWN0ZXN0LmMgYi9zcmMvY3lj
bGljdGVzdC9jeWNsaWN0ZXN0LmMKaW5kZXggZjg3ODIxNy4uY2VkYzM2ZiAxMDA2NDQKLS0tIGEv
c3JjL2N5Y2xpY3Rlc3QvY3ljbGljdGVzdC5jCisrKyBiL3NyYy9jeWNsaWN0ZXN0L2N5Y2xpY3Rl
c3QuYwpAQCAtNjg4LDcgKzY4OCw4IEBAIHN0YXRpYyB2b2lkIGRpc3BsYXlfaGVscCh2b2lkKQog
ICAgICAgICAgICAgICAiLWQgRElTVCAgLS1kaXN0YW5jZT1ESVNUICAgZGlzdGFuY2Ugb2YgdGhy
ZWFkIGludGVydmFscyBpbiB1cyBkZWZhdWx0PTUwMFxuIgogICAgICAgICAgICAgICAiLUUgICAg
ICAgLS1ldmVudCAgICAgICAgICAgZXZlbnQgdHJhY2luZyAodXNlZCB3aXRoIC1iKVxuIgogICAg
ICAgICAgICAgICAiLWYgICAgICAgLS1mdHJhY2UgICAgICAgICAgZnVuY3Rpb24gdHJhY2UgKHdo
ZW4gLWIgaXMgYWN0aXZlKVxuIgotICAgICAgICAgICAgICAiLWggSF9NQVggICAgICAgICAgICAg
ICAgICAgbGF0ZW5jeSBoaXN0b2dyYW0gc2l6ZSBpbiB1cyBkZWZhdWx0IDAgKG9mZilcbiIKKyAg
ICAgICAgICAgICAgIi1oICAgICAgIC0taGlzdG9ncmFtPVVTICAgIGR1bXAgYSBsYXRlbmN5IGhp
c3RvZ3JhbSB0byBzdGRvdXQgYWZ0ZXIgdGhlIHJ1blxuIgorICAgICAgICAgICAgICAiICAgICAg
ICAgICAgICAgICAgICAgICAgICAgVVMgaXMgdGhlIG1heCB0aW1lIHRvIGJlIGJlIHRyYWNrZWQg
aW4gbWljcm9zZWNvbmRzXG4iCiAgICAgICAgICAgICAgICItaSBJTlRWICAtLWludGVydmFsPUlO
VFYgICBiYXNlIGludGVydmFsIG9mIHRocmVhZCBpbiB1cyBkZWZhdWx0PTEwMDBcbiIKICAgICAg
ICAgICAgICAgIi1JICAgICAgIC0taXJxc29mZiAgICAgICAgIElycXNvZmYgdHJhY2luZyAodXNl
ZCB3aXRoIC1iKVxuIgogICAgICAgICAgICAgICAiLWwgTE9PUFMgLS1sb29wcz1MT09QUyAgICAg
bnVtYmVyIG9mIGxvb3BzOiBkZWZhdWx0PTAoZW5kbGVzcylcbiIKQEAgLTcxMCw4ICs3MTEsNiBA
QCBzdGF0aWMgdm9pZCBkaXNwbGF5X2hlbHAodm9pZCkKICAgICAgICAgICAgICAgIi1EICAgICAg
IC0tZHVyYXRpb249dCAgICAgIHNwZWNpZnkgYSBsZW5ndGggZm9yIHRoZSB0ZXN0IHJ1blxuIgog
ICAgICAgICAgICAgICAiICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVmYXVsdCBpcyBpbiBz
ZWNvbmRzLCBidXQgJ20nLCAnaCcsIG9yICdkJyBtYXliZSBhZGRlZFxuIgogICAgICAgICAgICAg
ICAiICAgICAgICAgICAgICAgICAgICAgICAgICAgdG8gbW9kaWZ5IHZhbHVlIHRvIG1pbnV0ZXMs
IGhvdXJzIG9yIGRheXNcbiIKLSAgICAgICAgICAgICAgIi1oICAgICAgIC0taGlzdG9ncmFtPVVT
ICAgIGR1bXAgYSBsYXRlbmN5IGhpc3RvZ3JhbSB0byBzdGRvdXQgYWZ0ZXIgdGhlIHJ1blxuIgot
ICAgICAgICAgICAgICAiICAgICAgICAgICAgICAgICAgICAgICAgICAgVVMgaXMgdGhlIG1heCB0
aW1lIHRvIGJlIGJlIHRyYWNrZWQgaW4gbWljcm9zZWNvbmRzXG4iCiAgICAgICAgICAgICAgICAp
OwogICAgICAgIGV4aXQoMCk7CiB9Cgo=
--000e0cd331de8f1a2e0466da0c27--
