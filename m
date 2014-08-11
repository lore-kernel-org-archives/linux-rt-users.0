From: Sadasivan Shaiju <sshaiju@mvista.com>
Subject: PATCH[2.6.32] kgdb patch
Date: Mon, 11 Aug 2014 14:33:59 -0700
Message-ID: <fe0d3c9469ec5339a06a472ddc418ba8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113941d6b80eed050061501d
Cc: shaiju_sada@yahoo.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:52647 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbaHKVeK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Aug 2014 17:34:10 -0400
Received: by mail-qa0-f42.google.com with SMTP id j15so8402693qaq.1
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Aug 2014 14:34:09 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--001a113941d6b80eed050061501d
Content-Type: text/plain; charset=UTF-8

Hi,

I  work for Montavista (Cavium Inc) as  a  Technical  Lead .  I want to
push some  of the kernel  patches to  rt community (2.6.32 kernel 2.6.33
rt patch)  , so  that  It  will  go  to  the  main line These patches  are
reviewed  and approved  by  our system Architect.  I request  you to
include  in the main line .  These  issues  were  reported  by our
customer CISCO.


Problem Description:
If  kprobes  is  enabled  along  with  kgdb, kgdb gives a SIGHUP on the
host side.

Root Cause:
Inside the do_page_fault() (arch/mips/mm/fault.c) there is a call to
notify_die() when kprobes is enabled.

When kgdb is enabled the register_die_notifier() handler catches this
exception
(which is 3 - TLB miss on store) and says it does not know it and returns
it as
a SIGHUP.

How Solved:
Made kgdb ignore this particular die notification (cmd == DIE_PAGE_FAULT)
in its
handler.


I  request you to include the above patch in to the main line kernel . If
any questions  please contact me at  sshaiju@mvista.com
(shaiju_sada@yahoo.com)


Regards,
Shaiju.

--001a113941d6b80eed050061501d
Content-Type: application/octet-stream;
	name="4995-kgdb-Ignore-DIE_PAGE_FAULT-event-in-notify-handler.patch"
Content-Disposition: attachment;
	filename="4995-kgdb-Ignore-DIE_PAGE_FAULT-event-in-notify-handler.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 94a297ddda1b478f_0.1

RnJvbSAwNTZjYWE5OTkxNTEyNzA0Y2IzOWY2NTgyOGUxZmZlYTQ3ODMwYzZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBzYWRhc2l2YW4gc2hhaWp1IDxzaGFpanVAbG9jYWxob3N0Lmxv
Y2FsZG9tYWluPgpEYXRlOiBXZWQsIDI3IEp1bCAyMDExIDE0OjU0OjM5IC0wNzAwClN1YmplY3Q6
IFtQQVRDSF0ga2dkYjogSWdub3JlIERJRV9QQUdFX0ZBVUxUIGV2ZW50IGluIG5vdGlmeSBoYW5k
bGVyCgpTb3VyY2U6IE1vbnRhVmlzdGEgU29mdHdhcmUsIExMQwpNUjogNDUyODAKVHlwZTogRGVm
ZWN0IEZpeApEaXNwb3NpdGlvbjogTmVlZHMgc3VibWl0dGluZyB0byBrZXJuZWwub3JnCkNoYW5n
ZUlEOiA1YmVjMDlmN2VjMGE0Nzc1MTY5ZjVjYmExNjk3NmJjM2E2YjQ1NTk4CkRlc2NyaXB0aW9u
OgoKSWdub3JlIG5vdGlmeV9kaWUoKSBmcm9tIGRvX3BhZ2VmYXVsdCgpLCBpbiBrZ2RiJ3MgcmVn
aXN0ZXJfZGllX25vdGlmaWVyKCkKaGFuZGxlcgoKU2lnbmVkLW9mZi1ieTogU2FkYXNpdmFuIDxz
c2hhaWp1QG12aXN0YS5jb20+ClNpZ25lZC1vZmYtYnk6IERhbGUgRmFybnN3b3J0aCA8ZGZhcm5z
d29ydGhAbXZpc3RhLmNvbT4KLS0tCiBhcmNoL21pcHMva2VybmVsL2tnZGIuYyB8ICAgIDUgKysr
KysKIDEgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2FyY2gvbWlwcy9rZXJuZWwva2dkYi5jIGIvYXJjaC9taXBzL2tlcm5lbC9rZ2Ri
LmMKaW5kZXggNTBjOWJiOC4uM2U0YWUzMSAxMDA2NDQKLS0tIGEvYXJjaC9taXBzL2tlcm5lbC9r
Z2RiLmMKKysrIGIvYXJjaC9taXBzL2tlcm5lbC9rZ2RiLmMKQEAgLTE5MSw2ICsxOTEsMTEgQEAg
c3RhdGljIGludCBrZ2RiX21pcHNfbm90aWZ5KHN0cnVjdCBub3RpZmllcl9ibG9jayAqc2VsZiwg
dW5zaWduZWQgbG9uZyBjbWQsCiAJc3RydWN0IHB0X3JlZ3MgKnJlZ3MgPSBhcmdzLT5yZWdzOwog
CWludCB0cmFwID0gKHJlZ3MtPmNwMF9jYXVzZSAmIDB4N2MpID4+IDI7CiAKKyAgICAgICAgLyog
aWdub3JlIHRoZSBub3RpZnlfZGllKCkgZnJvbSBkb19wYWdlX2ZhdWx0KCksIHdoaWNoIGlzIG1l
YW50IGZvciBrcHJvYmVzICovCisKKwlpZihjbWQgPT0gRElFX1BBR0VfRkFVTFQpCisJCXJldHVy
biBOT1RJRllfRE9ORTsgICAgICAgCisKIAkvKiBVc2VycGFjZSBldmVudHMsIGlnbm9yZS4gKi8K
IAlpZiAodXNlcl9tb2RlKHJlZ3MpKQogCQlyZXR1cm4gTk9USUZZX0RPTkU7Ci0tIAoxLjcuMC4x
Cgo=
--001a113941d6b80eed050061501d--
