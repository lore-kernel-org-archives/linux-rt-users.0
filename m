From: Sadasivan Shaiju <sshaiju@mvista.com>
Subject: PATCH[2.6.32] softirq patch
Date: Mon, 11 Aug 2014 14:21:40 -0700
Message-ID: <9dcf49abe0cd0e331df7b5faa37265ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11330c18af003d0500612441
Cc: shaiju_sada@yahoo.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:52202 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbaHKVVv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Aug 2014 17:21:51 -0400
Received: by mail-qa0-f41.google.com with SMTP id j7so8420432qaq.14
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Aug 2014 14:21:50 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--001a11330c18af003d0500612441
Content-Type: text/plain; charset=UTF-8

Hi ,

I  work for Montavista (Cavium Inc) as  a  Technical  Lead .  I want to
push some  of the kernel  patches to  rt community (2.6.32 kernel 2.6.33
rt patch)  , so  that  It  will  go  to  the  main line
These patches  are reviewed  and approved  by  our system Architect.  I
request  you to  include  in the main line .  These  issues  were
reported  by our customer CISCO.

Problem Description:
>From time to time, the following warning appears in the kernel logs on
x86, OCTEON Plus and Octeon II:

NOHZ: local_softirq_pending 08

Root Cause:
In run_ksoftirqd, _local_bh_enable() is used to enable bottom half.
This does not kick off softirq processing.

How Solved:
In run_ksoftirqd, _local_bh_enable() has been replaced with
local_bh_enable() to
enable softirq processing .

Here  I  am attaching  the  patch  for  the  above  bug .   If  any
questions  please  contact  me  at    sshaiju@mvista.com
(shaiju_sada@yahoo.com)

Regards,
Shaiju.

--001a11330c18af003d0500612441
Content-Type: application/octet-stream;
	name="5282-softirq-Call-do_softirq-from-run_ksoftirqd-when-need.patch"
Content-Disposition: attachment;
	filename="5282-softirq-Call-do_softirq-from-run_ksoftirqd-when-need.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7971ddf931761d85_0.1

RnJvbSAyZmE3MTIxYjkxMjc1NGY4MTQ5Nzc0ZDZhMDEyYmVjZjU0MmZmYTE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYWRhc2l2YW4gU2hhaWp1IDxzc2hhaWp1QG12aXN0YS5jb20+
CkRhdGU6IE1vbiwgNiBGZWIgMjAxMiAxODo1NDo1MyAtMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHNv
ZnRpcnE6IENhbGwgZG9fc29mdGlycSgpIGZyb20gcnVuX2tzb2Z0aXJxZCgpIHdoZW4gbmVlZGVk
CgpTb3VyY2U6IE1vbnRhVmlzdGEgU29mdHdhcmUsIExMQwpNUjogNDczNzEKVHlwZTogRGVmZWN0
IEZpeApEaXNwb3NpdGlvbjogTG9jYWwKQ2hhbmdlSUQ6IDMwNjZiMWY5NzFlMTZiM2ZjMjJlNmM0
ZTRiYmE5YzY3ODY4MTFhY2MKRGVzY3JpcHRpb246CgpJbiBydW5fa3NvZnRpcnFkIF9sb2NhbF9i
aF9lbmFibGUoKSBoYXMgdG8gYmUgcmVwbGFjZWQgd2l0aApsb2NhbF9iaF9lbmFibGUoKSB0byBl
bmFibGUgc29mdGlycSBwcm9jZXNzaW5nLgoKVGhlIGNhbGwgdG8gX2xvY2FsX2JoX2VuYWJsZSgp
IHdhcyBpbnRyb2R1Y2VkIGluIHRoZSBtZXJnZSBvZgpSVCBwYXRjaC0yLjYuMzMtcnQ3LgoKU2ln
bmVkLW9mZi1ieTogU2FkYXNpdmFuIFNoYWlqdSA8c3NoYWlqdUBtdmlzdGEuY29tPgpTaWduZWQt
b2ZmLWJ5OiBEYWxlIEZhcm5zd29ydGggPGRmYXJuc3dvcnRoQG12aXN0YS5jb20+Ci0tLQoga2Vy
bmVsL3NvZnRpcnEuYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC9zb2Z0aXJxLmMgYi9rZXJuZWwv
c29mdGlycS5jCmluZGV4IDY3MTE2YzguLmNkZjUyZDIgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9zb2Z0
aXJxLmMKKysrIGIva2VybmVsL3NvZnRpcnEuYwpAQCAtMTA4MCw3ICsxMDgwLDcgQEAgc2xlZXBf
bW9yZToKIAogCQkJbG9jYWxfaXJxX2Rpc2FibGUoKTsKIAkJCXBlcl9jcHUoc29mdGlycV9ydW5u
aW5nLCBjcHUpICY9IH5zb2Z0aXJxX21hc2s7Ci0JCQlfbG9jYWxfYmhfZW5hYmxlKCk7CisJCQls
b2NhbF9iaF9lbmFibGUoKTsKIAkJCWxvY2FsX2lycV9lbmFibGUoKTsKIAogCQkJY29uZF9yZXNj
aGVkKCk7Ci0tIAoxLjcuMC4xCgo=
--001a11330c18af003d0500612441--
