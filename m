From: Piotr Gregor <piotrgregor@rsyncme.org>
Subject: Calculate average latencies on the fly
Date: Mon, 14 Nov 2016 10:00:48 +0000
Message-ID: <CAK+oA4V8yFDnieAa4tsCQKTapNe6gA_VLJvvEh6_u_jgWpyahQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c081bb60bd47e05413fea77
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:32818 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbcKNKAt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Nov 2016 05:00:49 -0500
Received: by mail-yw0-f179.google.com with SMTP id r204so52697099ywb.0
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Nov 2016 02:00:49 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--94eb2c081bb60bd47e05413fea77
Content-Type: text/plain; charset=UTF-8

Hi,

There is a possibility for average to overflow as it is first accumulated
and only divided when printing statistics. Attached is the patch
to calculate average on the go.

Patch is diffed between stable/v1.0 branch
git format-patch origin/stable/v1.0 --stdout > calc_average_on_the_fly.patch

cheers,
Piotr

--94eb2c081bb60bd47e05413fea77
Content-Type: text/x-patch; charset=US-ASCII; name="calc_average_on_the_fly.patch"
Content-Disposition: attachment; filename="calc_average_on_the_fly.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ivhwe1n40

RnJvbSBjYjlhODUyMjJkZmYxYTI5OWZkZTI1YTk2MjQzMTM5Y2RlNmE0OTQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaW90ciBHcmVnb3IgPHBpb3RyZ3JlZ29yQHJzeW5jbWUub3Jn
PgpEYXRlOiBGcmksIDExIE5vdiAyMDE2IDExOjI4OjA5ICswMDAwClN1YmplY3Q6IFtQQVRDSF0g
cnQtdGVzdHM6IGN5Y2xpY3Rlc3Q6IENhbGN1bGF0ZSBhdmVyYWdlIGxhdGVuY2llcyBvbiB0aGUg
Zmx5CgpQcmV2ZW50cyBzdGF0LT5hdmcgdmFyaWFibGUgZnJvbSBvdmVyZmxvdy4KLS0tCiBzcmMv
Y3ljbGljdGVzdC9jeWNsaWN0ZXN0LmMgfCAxMCArKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9jeWNsaWN0
ZXN0L2N5Y2xpY3Rlc3QuYyBiL3NyYy9jeWNsaWN0ZXN0L2N5Y2xpY3Rlc3QuYwppbmRleCAzZjFi
ZWYxLi4yYzRlNDUwIDEwMDY0NAotLS0gYS9zcmMvY3ljbGljdGVzdC9jeWNsaWN0ZXN0LmMKKysr
IGIvc3JjL2N5Y2xpY3Rlc3QvY3ljbGljdGVzdC5jCkBAIC0xMTc4LDcgKzExNzgsMTEgQEAgc3Rh
dGljIHZvaWQgKnRpbWVydGhyZWFkKHZvaWQgKnBhcmFtKQogCQkJaWYgKHJlZnJlc2hfb25fbWF4
KQogCQkJCXB0aHJlYWRfY29uZF9zaWduYWwoJnJlZnJlc2hfb25fbWF4X2NvbmQpOwogCQl9Ci0J
CXN0YXQtPmF2ZyArPSAoZG91YmxlKSBkaWZmOworCQlpZiAoc3RhdC0+Y3ljbGVzID09IDApIHsK
KwkJCXN0YXQtPmF2ZyA9IChkb3VibGUpIGRpZmY7CisJCX0gZWxzZSB7CisJCQlzdGF0LT5hdmcg
PSAoc3RhdC0+YXZnICsgKGRvdWJsZSkgZGlmZikgKiAoKGRvdWJsZSkgc3RhdC0+Y3ljbGVzIC8g
KGRvdWJsZSkgKHN0YXQtPmN5Y2xlcyArIDEpKTsKKwkJfQogCiAJCWlmICh0cmlnZ2VyICYmIChk
aWZmID4gdHJpZ2dlcikpIHsKIAkJCXRyaWdnZXJfdXBkYXRlKHBhciwgZGlmZiwgY2FsY3RpbWUo
bm93KSk7CkBAIC0yMDA1LDcgKzIwMDksNyBAQCBzdGF0aWMgdm9pZCBwcmludF9oaXN0KHN0cnVj
dCB0aHJlYWRfcGFyYW0gKnBhcltdLCBpbnQgbnRocmVhZHMpCiAJZnByaW50ZihmZCwgIiMgQXZn
IExhdGVuY2llczoiKTsKIAlmb3IgKGogPSAwOyBqIDwgbnRocmVhZHM7IGorKykKIAkJZnByaW50
ZihmZCwgIiAlMDVsdSIsIHBhcltqXS0+c3RhdHMtPmN5Y2xlcyA/Ci0JCSAgICAgICAobG9uZyko
cGFyW2pdLT5zdGF0cy0+YXZnL3BhcltqXS0+c3RhdHMtPmN5Y2xlcykgOiAwKTsKKwkJICAgICAg
IChsb25nKShwYXJbal0tPnN0YXRzLT5hdmcpIDogMCk7CiAJZnByaW50ZihmZCwgIlxuIik7CiAJ
ZnByaW50ZihmZCwgIiMgTWF4IExhdGVuY2llczoiKTsKIAltYXhtYXggPSAwOwpAQCAtMjA1OSw3
ICsyMDYzLDcgQEAgc3RhdGljIHZvaWQgcHJpbnRfc3RhdChGSUxFICpmcCwgc3RydWN0IHRocmVh
ZF9wYXJhbSAqcGFyLCBpbnQgaW5kZXgsIGludCB2ZXJib3MKIAkJCWZwcmludGYoZnAsIGZtdCwg
aW5kZXgsIHN0YXQtPnRpZCwgcGFyLT5wcmlvLAogCQkJCXBhci0+aW50ZXJ2YWwsIHN0YXQtPmN5
Y2xlcywgc3RhdC0+bWluLAogCQkJCXN0YXQtPmFjdCwgc3RhdC0+Y3ljbGVzID8KLQkJCQkobG9u
Zykoc3RhdC0+YXZnL3N0YXQtPmN5Y2xlcykgOiAwLCBzdGF0LT5tYXgpOworCQkJCShsb25nKShz
dGF0LT5hdmcpIDogMCwgc3RhdC0+bWF4KTsKIAogCQkJaWYgKHNtaSkKIAkJCQlmcHJpbnRmKGZw
LCIgU01JOiU4bGQiLCBzdGF0LT5zbWlfY291bnQpOwotLSAKMi43LjQKCg==
--94eb2c081bb60bd47e05413fea77--
