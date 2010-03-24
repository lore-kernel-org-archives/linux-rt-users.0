From: Pradyumna Sampath <pradysam@gmail.com>
Subject: Re: [PATCH] mq_timedrecieve timeout accuracy
Date: Wed, 24 Mar 2010 16:46:21 +0100
Message-ID: <6d09081c1003240846s31fa5917p470f8936a39662f@mail.gmail.com>
References: <6d09081c1003240527r471ee34etbba11b4b7c7e92b3@mail.gmail.com>
	 <8226231.1269436934345.JavaMail.ngmail@webmail10.arcor-online.net>
	 <6d09081c1003240637w28ee6861tfcef4c7876ef3e40@mail.gmail.com>
	 <6d09081c1003240703o19ad3dffx20abae9d15e2d0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00148530ad9ff936d104828dd427
Cc: linux-rt-users@vger.kernel.org, rachana.rao@in.abb.com
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:40573 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095Ab0CXPqX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Mar 2010 11:46:23 -0400
Received: by ewy8 with SMTP id 8so1337335ewy.28
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Mar 2010 08:46:22 -0700 (PDT)
In-Reply-To: <6d09081c1003240703o19ad3dffx20abae9d15e2d0b@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--00148530ad9ff936d104828dd427
Content-Type: text/plain; charset=ISO-8859-1

Hi,

On Wed, Mar 24, 2010 at 3:03 PM, Pradyumna Sampath <pradysam@gmail.com> wrote:
> Ok, I just moved the HZ value from 250 to 1000 and the accuracy has
> improved significantly from 5-7 to 1-2 miliseconds. But IMHO, we
> should still change schedule_timeout to schedule_hrtimeout for better
> accuracy on the timeout because in many cases 1-2 miliseconds is just
> not good enough.

Ok, as promised.

Here is a dirty hack that I made which basically resulted in 2 things.
1) My test programs accurace really really improved. The timeout on
the mq_timedrecieve this time around within the tune of 20-30uS.
2) My actual application exploded all over the place, with mq_*
functions complaining of timing out etc etc .. Just a bad messup.

So (1) confirms that sched_hrtimeout could be a good idea. (2)
Confirms that this patch is really terrible and it would be great if
someone could either come up with something that is more robust or I
will be happy to take suggestions on where and how I should make
changes.

regards
/prady

-- 
http://www.prady.in

--00148530ad9ff936d104828dd427
Content-Type: application/octet-stream;
	name=ipc_mqueue_timeout_to_hrtimeout
Content-Disposition: attachment; filename=ipc_mqueue_timeout_to_hrtimeout
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g76b1plf0

SW5kZXg6IGxpbnV4LTIuNi4zMy4xLXJ0MTAvaXBjL21xdWV1ZS5jCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxp
bnV4LTIuNi4zMy4xLXJ0MTAvaXBjL21xdWV1ZS5jCShyZXZpc2lvbiA4MDEpCisrKyBsaW51eC0y
LjYuMzMuMS1ydDEwL2lwYy9tcXVldWUuYwkod29ya2luZyBjb3B5KQpAQCAtNDI4LDEwICs0Mjgs
MTIgQEAKICAqIHNyOiBTRU5EIG9yIFJFQ1YKICAqLwogc3RhdGljIGludCB3cV9zbGVlcChzdHJ1
Y3QgbXF1ZXVlX2lub2RlX2luZm8gKmluZm8sIGludCBzciwKLQkJCWxvbmcgdGltZW91dCwgc3Ry
dWN0IGV4dF93YWl0X3F1ZXVlICpld3ApCisJCQlzdHJ1Y3QgdGltZXNwZWMgdGltZW91dCwgc3Ry
dWN0IGV4dF93YWl0X3F1ZXVlICpld3ApCiB7CiAJaW50IHJldHZhbDsKIAlzaWduZWQgbG9uZyB0
aW1lOworCWt0aW1lX3QgZXhwaXJlID0gdGltZXNwZWNfdG9fa3RpbWUodGltZW91dCk7CisJLy9w
cmludGsoInRpbWVvdXQgPSAlbGQgJWxkXG4iLHRpbWVvdXQudHZfc2VjLCB0aW1lb3V0LnR2X25z
ZWMpOwogCiAJd3FfYWRkKGluZm8sIHNyLCBld3ApOwogCkBAIC00MzksNyArNDQxLDggQEAKIAkJ
c2V0X2N1cnJlbnRfc3RhdGUoVEFTS19JTlRFUlJVUFRJQkxFKTsKIAogCQlzcGluX3VubG9jaygm
aW5mby0+bG9jayk7Ci0JCXRpbWUgPSBzY2hlZHVsZV90aW1lb3V0KHRpbWVvdXQpOworCQkvL3Rp
bWUgPSBzY2hlZHVsZV90aW1lb3V0KHRpbWVvdXQpOworCQl0aW1lID0gc2NoZWR1bGVfaHJ0aW1l
b3V0KCZleHBpcmUsSFJUSU1FUl9NT0RFX1JFTCk7CiAKIAkJd2hpbGUgKGV3cC0+c3RhdGUgPT0g
U1RBVEVfUEVORElORykKIAkJCWNwdV9yZWxheCgpOwpAQCAtODY0LDYgKzg2Nyw3IEBACiAJbG9u
ZyB0aW1lb3V0OwogCWludCByZXQ7CiAKKwogCWlmICh1X2Fic190aW1lb3V0KSB7CiAJCWlmIChj
b3B5X2Zyb21fdXNlcigmdHMsIHVfYWJzX3RpbWVvdXQsIAogCQkJCQlzaXplb2Yoc3RydWN0IHRp
bWVzcGVjKSkpCkBAIC05MTksNyArOTIzLDggQEAKIAkJCXdhaXQudGFzayA9IGN1cnJlbnQ7CiAJ
CQl3YWl0Lm1zZyA9ICh2b2lkICopIG1zZ19wdHI7CiAJCQl3YWl0LnN0YXRlID0gU1RBVEVfTk9O
RTsKLQkJCXJldCA9IHdxX3NsZWVwKGluZm8sIFNFTkQsIHRpbWVvdXQsICZ3YWl0KTsKKwkJCS8v
cmV0ID0gd3Ffc2xlZXAoaW5mbywgU0VORCwgdGltZW91dCwgJndhaXQpOworCQkJcmV0ID0gd3Ff
c2xlZXAoaW5mbywgU0VORCwgdHMsICZ3YWl0KTsKIAkJfQogCQlpZiAocmV0IDwgMCkKIAkJCWZy
ZWVfbXNnKG1zZ19wdHIpOwpAQCAtOTU2LDYgKzk2MSw3IEBACiAJc3RydWN0IGV4dF93YWl0X3F1
ZXVlIHdhaXQ7CiAJc3RydWN0IHRpbWVzcGVjIHRzLCAqcCA9IE5VTEw7CiAKKwogCWlmICh1X2Fi
c190aW1lb3V0KSB7CiAJCWlmIChjb3B5X2Zyb21fdXNlcigmdHMsIHVfYWJzX3RpbWVvdXQsIAog
CQkJCQlzaXplb2Yoc3RydWN0IHRpbWVzcGVjKSkpCkBAIC05NjYsNiArOTcyLDcgQEAKIAlhdWRp
dF9tcV9zZW5kcmVjdihtcWRlcywgbXNnX2xlbiwgMCwgcCk7CiAJdGltZW91dCA9IHByZXBhcmVf
dGltZW91dChwKTsKIAorCS8vcHJpbnRrKCJ0aW1lZHJlY2lldmUgPSAlbGQgJWxkXG4iLHRzLnR2
X3NlYywgdHMudHZfbnNlYyk7CiAJcmV0ID0gLUVCQURGOwogCWZpbHAgPSBmZ2V0KG1xZGVzKTsK
IAlpZiAodW5saWtlbHkoIWZpbHApKQpAQCAtOTk5LDcgKzEwMDYsOCBAQAogCQl9IGVsc2Ugewog
CQkJd2FpdC50YXNrID0gY3VycmVudDsKIAkJCXdhaXQuc3RhdGUgPSBTVEFURV9OT05FOwotCQkJ
cmV0ID0gd3Ffc2xlZXAoaW5mbywgUkVDViwgdGltZW91dCwgJndhaXQpOworCQkJLy9yZXQgPSB3
cV9zbGVlcChpbmZvLCBSRUNWLCB0aW1lb3V0LCAmd2FpdCk7CisJCQlyZXQgPSB3cV9zbGVlcChp
bmZvLCBSRUNWLCB0cywgJndhaXQpOwogCQkJbXNnX3B0ciA9IHdhaXQubXNnOwogCQl9CiAJfSBl
bHNlIHsKCg==
--00148530ad9ff936d104828dd427--
