From: Sadasivan Shaiju <sshaiju@mvista.com>
Subject: PATCH[2.6.32] scheduler patch
Date: Mon, 11 Aug 2014 17:36:18 -0700
Message-ID: <47e73b84899aeb9cc144e29a226920e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1135637e10becd050063dd9b
Cc: shaiju_sada@yahoo.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:33185 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbaHLAge (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Aug 2014 20:36:34 -0400
Received: by mail-qa0-f54.google.com with SMTP id k15so8372298qaq.41
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Aug 2014 17:36:34 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--001a1135637e10becd050063dd9b
Content-Type: text/plain; charset=UTF-8

Hi,

I  work for Montavista (Cavium Inc) as  a  Technical  Lead .  I want to
push some  of the kernel  patches to  rt community (2.6.32 kernel 2.6.33
rt patch)  , so  that  It  will  go  to  the  main line These patches  are
reviewed  and approved  by  our system Architect.  I request  you to
include  in the main line .  These  issue  was  reported  by our customer
CISCO.

Problem Description:
  In some cases the task state of a task is set incorrectly, resulting in
a
  hung task.

Root Cause:
  Trying to claim the BKL while PREEMPT_ACTIVE is set will result in
  __schedule returning immediately in __mutex_lock_common().  This means
  the task state will not be set to running by the wakeup, and it also
means
  that the kernel will just sit there and spin waiting for the mutex,
which
  is bad.

  This occurs in __cond_resched, which calls schedule() with
PREEMPT_ACTIVE
  set.  The other places that call schedule() with PREEMPT_ACTIVE set have
  special code that plays with the BKL.

How Solved:
  To fix this, moved releasing and reclaiming the BKL to outside setting
  the PREEMPT_ACTIVE bit.


I request  you to include the above patch  to  the main line .  If  any
questions  please contact me at  sshaiju@mvista.com
(shaiju_sada@yahoo.com)


Regards,
Shaiju.

--001a1135637e10becd050063dd9b
Content-Type: application/octet-stream;
	name="5913-Fix-BKL-problems-leading-to-bad-task-state.patch"
Content-Disposition: attachment;
	filename="5913-Fix-BKL-problems-leading-to-bad-task-state.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: df086c2b4eacf988_0.1

RnJvbSA3NmFjM2I3NTU1YWQ1ODExMDlmN2FkZTI4ZmIwZmZkZGUyN2U1YjQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDb3JleSBNaW55YXJkIDxjbWlueWFyZEBtdmlzdGEuY29tPgpE
YXRlOiBGcmksIDI5IEp1biAyMDEyIDE2OjAzOjI0IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gRml4
IEJLTCBwcm9ibGVtcyBsZWFkaW5nIHRvIGJhZCB0YXNrIHN0YXRlCgpTb3VyY2U6IE1vbnRhVmlz
dGEgU29mdHdhcmUsIExMQwpNUjogNTE0ODAKVHlwZTogRGVmZWN0IEZpeApEaXNwb3NpdGlvbjog
TG9jYWwKQ2hhbmdlSUQ6IDExNzc3YzM1YmNkMmIzYmEwOTEzN2MxZWNkMGVlNWZlNzI0ZDJiNzEK
RGVzY3JpcHRpb246CgpUcnlpbmcgdG8gY2xhaW0gdGhlIEJLTCB3aGlsZSBQUkVFTVBUX0FDVElW
RSBpcyBzZXQgd2lsbCByZXN1bHQgaW4KX19zY2hlZHVsZSByZXR1cm5pbmcgaW1tZWRpYXRlbHkg
aW4gX19tdXRleF9sb2NrX2NvbW1vbigpLiAgVGhpcyBtZWFucwp0aGUgdGFzayBzdGF0ZSB3b24n
dCBiZSBzZXQgdG8gcnVubmluZyBieSB0aGUgd2FrZXVwLCBhbmQgaXQgYWxzZSBtZWFucwp0aGF0
IHRoZSBrZXJuZWwgd2lsbCBqdXN0IHNpdCB0aGVyZSBhbmQgc3BpbiB3YWl0aW5nIGZvciB0aGUg
bXV0ZXgsIHdoaWNoCmlzIGJhZC4KClRoaXMgb2NjdXJzIGluIF9fY29uZF9yZXNjaGVkLCB3aGlj
aCBjYWxscyBzY2hlZHVsZSgpIHdpdGggUFJFRU1QVF9BQ1RJVkUKc2V0LiAgVGhlIG90aGVyIHBs
YWNlcyB0aGF0IGNhbGwgc2NoZWR1bGUoKSB3aXRoIFBSRUVNUFRfQUNUSVZFIHNldCBoYXZlCnNw
ZWNpYWwgY29kZSB0aGF0IHBsYXlzIHdpdGggdGhlIEJLTC4KClRvIGZpeCB0aGlzLCBtb3ZlIHJl
bGVhc2luZyBhbmQgcmVjbGFpbWluZyB0aGUgQktMIHRvIG91dHNpZGUgc2V0dGluZwp0aGUgUFJF
RU1QVF9BQ1RJVkUgYml0LgoKTm90ZSB0aGF0IHNpbmNlIHRoZXJlIGlzIG5vIEJLTCBhbnkgbW9y
ZSwgdGhlcmUgaXMgbm8gbmVlZCB0byBzZW5kIHVwc3RyZWFtLgoKU2lnbmVkLW9mZi1ieTogQ29y
ZXkgTWlueWFyZCA8Y21pbnlhcmRAbXZpc3RhLmNvbT4KU2lnbmVkLW9mZi1ieTogUmFuZHkgVmlu
c29uIDxydmluc29uQG12aXN0YS5jb20+ClNpZ25lZC1vZmYtYnk6IFNhZGFzaXZhbiBTaGFpanUg
PHNzaGFpanVAbXZpc3RhLmNvbT4KLS0tCiBrZXJuZWwvc2NoZWQuYyB8ICAgMjkgKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwg
OCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQuYyBiL2tlcm5lbC9zY2hl
ZC5jCmluZGV4IDRlMmQwZGUuLjdjNzczZTUgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9zY2hlZC5jCisr
KyBiL2tlcm5lbC9zY2hlZC5jCkBAIC01ODc2LDIxICs1ODc2LDE1IEBAIHBpY2tfbmV4dF90YXNr
KHN0cnVjdCBycSAqcnEpCiAvKgogICogc2NoZWR1bGUoKSBpcyB0aGUgbWFpbiBzY2hlZHVsZXIg
ZnVuY3Rpb24uCiAgKi8KLWFzbWxpbmthZ2Ugdm9pZCBfX3NjaGVkIF9fc2NoZWR1bGUodm9pZCkK
K3N0YXRpYyB2b2lkIF9fc2NoZWQgX19zY2hlZHVsZV9ub2JrbChpbnQgY3B1LCBzdHJ1Y3QgcnEg
KnJxKQogewogCXN0cnVjdCB0YXNrX3N0cnVjdCAqcHJldiwgKm5leHQ7CiAJdW5zaWduZWQgbG9u
ZyAqc3dpdGNoX2NvdW50OwotCXN0cnVjdCBycSAqcnE7Ci0JaW50IGNwdTsKIAotCWNwdSA9IHNt
cF9wcm9jZXNzb3JfaWQoKTsKLQlycSA9IGNwdV9ycShjcHUpOwogCXJjdV9zY2hlZF9xcyhjcHUp
OwogCXByZXYgPSBycS0+Y3VycjsKIAlzd2l0Y2hfY291bnQgPSAmcHJldi0+bml2Y3N3OwogCi0J
cmVsZWFzZV9rZXJuZWxfbG9jayhwcmV2KTsKLQogCXNjaGVkdWxlX2RlYnVnKHByZXYpOwogCiAJ
cHJlZW1wdF9kaXNhYmxlKCk7CkBAIC01OTQyLDcgKzU5MzYsMTcgQEAgYXNtbGlua2FnZSB2b2lk
IF9fc2NoZWQgX19zY2hlZHVsZSh2b2lkKQogCX0KIAogCXBvc3Rfc2NoZWR1bGUocnEpOworfQog
Cithc21saW5rYWdlIHZvaWQgX19zY2hlZCBfX3NjaGVkdWxlKHZvaWQpCit7CisJc3RydWN0IHJx
ICpycTsKKwlpbnQgY3B1OworCisJY3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOworCXJxID0gY3B1
X3JxKGNwdSk7CisJcmVsZWFzZV9rZXJuZWxfbG9jayhycS0+Y3Vycik7CisJX19zY2hlZHVsZV9u
b2JrbChjcHUsIHJxKTsKIAlyZWFjcXVpcmVfa2VybmVsX2xvY2soY3VycmVudCk7CiB9CiAKQEAg
LTcyNjAsMTAgKzcyNjQsMTkgQEAgc3RhdGljIGlubGluZSBpbnQgc2hvdWxkX3Jlc2NoZWQodm9p
ZCkKIAogc3RhdGljIHZvaWQgX19jb25kX3Jlc2NoZWQodm9pZCkKIHsKKwlzdHJ1Y3QgcnEgKnJx
OworCWludCBjcHU7CisKIAlkbyB7CisJCWxvY2FsX2lycV9kaXNhYmxlKCk7CisJCWNwdSA9IHNt
cF9wcm9jZXNzb3JfaWQoKTsKKwkJcnEgPSBjcHVfcnEoY3B1KTsKKwkJcmVsZWFzZV9rZXJuZWxf
bG9jayhycS0+Y3Vycik7CiAJCWFkZF9wcmVlbXB0X2NvdW50KFBSRUVNUFRfQUNUSVZFKTsKLQkJ
c2NoZWR1bGUoKTsKKwkJX19zY2hlZHVsZV9ub2JrbChjcHUsIHJxKTsKIAkJc3ViX3ByZWVtcHRf
Y291bnQoUFJFRU1QVF9BQ1RJVkUpOworCQlyZWFjcXVpcmVfa2VybmVsX2xvY2soY3VycmVudCk7
CisJCWxvY2FsX2lycV9lbmFibGUoKTsKIAogCQkvKgogCQkgKiBDaGVjayBhZ2FpbiBpbiBjYXNl
IHdlIG1pc3NlZCBhIHByZWVtcHRpb24gb3Bwb3J0dW5pdHkKLS0gCjEuNy4wLjEKCg==
--001a1135637e10becd050063dd9b--
