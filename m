From: Piotr Gregor <piotrgregor@rsyncme.org>
Subject: Re: Calculate average latencies on the fly
Date: Mon, 14 Nov 2016 11:50:00 +0000
Message-ID: <CAK+oA4WFAaT4DmR=8nKqTsyKe9imDYCu5p6DG4kqbhoBPD=LXw@mail.gmail.com>
References: <CAK+oA4V8yFDnieAa4tsCQKTapNe6gA_VLJvvEh6_u_jgWpyahQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c145a6a98a0190541417044
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33889 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbcKNLuC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Nov 2016 06:50:02 -0500
Received: by mail-yw0-f178.google.com with SMTP id t125so54783372ywc.1
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Nov 2016 03:50:01 -0800 (PST)
In-Reply-To: <CAK+oA4V8yFDnieAa4tsCQKTapNe6gA_VLJvvEh6_u_jgWpyahQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--94eb2c145a6a98a0190541417044
Content-Type: text/plain; charset=UTF-8

There was an error in previous patch. Please find attached corrected patch.

cheers,
Piotr

--94eb2c145a6a98a0190541417044
Content-Type: text/x-patch; charset=US-ASCII; name="calc_average_on_the_fly.patch"
Content-Disposition: attachment; filename="calc_average_on_the_fly.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ivi0bi3g1

RnJvbSA1NjEwZTJiMDFlNTMwMmE1ZWNmZjdjYTM2ODE5ODg2M2E2Y2U5Zjc4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaW90ciBHcmVnb3IgPHBpb3RyZ3JlZ29yQHJzeW5jbWUub3Jn
PgpEYXRlOiBGcmksIDExIE5vdiAyMDE2IDExOjI4OjA5ICswMDAwClN1YmplY3Q6IFtQQVRDSF0g
cnQtdGVzdHM6IGN5Y2xpY3Rlc3Q6IENhbGN1bGF0ZSBhdmVyYWdlIGxhdGVuY2llcyBvbiB0aGUg
Zmx5CgpQcmV2ZW50cyBzdGF0LT5hdmcgdmFyaWFibGUgZnJvbSBvdmVyZmxvdy4KLS0tCiBzcmMv
Y3ljbGljdGVzdC9jeWNsaWN0ZXN0LmMgfCAxMCArKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9jeWNsaWN0
ZXN0L2N5Y2xpY3Rlc3QuYyBiL3NyYy9jeWNsaWN0ZXN0L2N5Y2xpY3Rlc3QuYwppbmRleCAzZjFi
ZWYxLi4wZDJkZGJjIDEwMDY0NAotLS0gYS9zcmMvY3ljbGljdGVzdC9jeWNsaWN0ZXN0LmMKKysr
IGIvc3JjL2N5Y2xpY3Rlc3QvY3ljbGljdGVzdC5jCkBAIC0xMTc4LDcgKzExNzgsMTEgQEAgc3Rh
dGljIHZvaWQgKnRpbWVydGhyZWFkKHZvaWQgKnBhcmFtKQogCQkJaWYgKHJlZnJlc2hfb25fbWF4
KQogCQkJCXB0aHJlYWRfY29uZF9zaWduYWwoJnJlZnJlc2hfb25fbWF4X2NvbmQpOwogCQl9Ci0J
CXN0YXQtPmF2ZyArPSAoZG91YmxlKSBkaWZmOworCQlpZiAoc3RhdC0+Y3ljbGVzID09IDApIHsK
KwkJCXN0YXQtPmF2ZyA9IChkb3VibGUpIGRpZmY7CisJCX0gZWxzZSB7CisJCQlzdGF0LT5hdmcg
PSAoc3RhdC0+YXZnICsgKGRvdWJsZSkgZGlmZiAvIChkb3VibGUpIHN0YXQtPmN5Y2xlcykgKiAo
KGRvdWJsZSkgc3RhdC0+Y3ljbGVzIC8gKGRvdWJsZSkgKHN0YXQtPmN5Y2xlcyArIDEpKTsKKwkJ
fQogCiAJCWlmICh0cmlnZ2VyICYmIChkaWZmID4gdHJpZ2dlcikpIHsKIAkJCXRyaWdnZXJfdXBk
YXRlKHBhciwgZGlmZiwgY2FsY3RpbWUobm93KSk7CkBAIC0yMDA1LDcgKzIwMDksNyBAQCBzdGF0
aWMgdm9pZCBwcmludF9oaXN0KHN0cnVjdCB0aHJlYWRfcGFyYW0gKnBhcltdLCBpbnQgbnRocmVh
ZHMpCiAJZnByaW50ZihmZCwgIiMgQXZnIExhdGVuY2llczoiKTsKIAlmb3IgKGogPSAwOyBqIDwg
bnRocmVhZHM7IGorKykKIAkJZnByaW50ZihmZCwgIiAlMDVsdSIsIHBhcltqXS0+c3RhdHMtPmN5
Y2xlcyA/Ci0JCSAgICAgICAobG9uZykocGFyW2pdLT5zdGF0cy0+YXZnL3BhcltqXS0+c3RhdHMt
PmN5Y2xlcykgOiAwKTsKKwkJICAgICAgIChsb25nKShwYXJbal0tPnN0YXRzLT5hdmcpIDogMCk7
CiAJZnByaW50ZihmZCwgIlxuIik7CiAJZnByaW50ZihmZCwgIiMgTWF4IExhdGVuY2llczoiKTsK
IAltYXhtYXggPSAwOwpAQCAtMjA1OSw3ICsyMDYzLDcgQEAgc3RhdGljIHZvaWQgcHJpbnRfc3Rh
dChGSUxFICpmcCwgc3RydWN0IHRocmVhZF9wYXJhbSAqcGFyLCBpbnQgaW5kZXgsIGludCB2ZXJi
b3MKIAkJCWZwcmludGYoZnAsIGZtdCwgaW5kZXgsIHN0YXQtPnRpZCwgcGFyLT5wcmlvLAogCQkJ
CXBhci0+aW50ZXJ2YWwsIHN0YXQtPmN5Y2xlcywgc3RhdC0+bWluLAogCQkJCXN0YXQtPmFjdCwg
c3RhdC0+Y3ljbGVzID8KLQkJCQkobG9uZykoc3RhdC0+YXZnL3N0YXQtPmN5Y2xlcykgOiAwLCBz
dGF0LT5tYXgpOworCQkJCShsb25nKShzdGF0LT5hdmcpIDogMCwgc3RhdC0+bWF4KTsKIAogCQkJ
aWYgKHNtaSkKIAkJCQlmcHJpbnRmKGZwLCIgU01JOiU4bGQiLCBzdGF0LT5zbWlfY291bnQpOwot
LSAKMi43LjQKCg==
--94eb2c145a6a98a0190541417044--
