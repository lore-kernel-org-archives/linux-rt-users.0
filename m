From: Dan Murphy <dmurphy@ti.com>
Subject: Re: Linux stable vs RT stable and RT dev
Date: Fri, 9 Feb 2018 12:59:43 -0600
Message-ID: <a1c7a58e-2d67-f6fd-6e91-9cbd03678e7d@ti.com>
References: <8155aea247374c058bd7c797124c3d28@ti.com>
 <20180202214611.GD868@jcartwri.amer.corp.natinst.com>
 <1c47b7e6-86d0-cbb0-9b72-7b7d63e46ddc@ti.com>
 <6eecb69a-e60f-f837-bc2c-a627e2660027@ti.com>
 <20180206143426.fdzs6hnvmakqdwiu@linutronix.de>
 <8e201971-d626-7ef6-addd-bbbc32f63770@ti.com>
 <20180209173921.mtz55hgs5idj4vhk@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------84DD25CA1B744C070FAE6AF2"
Cc: William Mills <wmills@ti.com>, Julia Cartwright <julia@ni.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>, <rostedt@goodmis.org>,
        "Hernandez, Carlos" <ceh@ti.com>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:23316 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeBIS75 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Feb 2018 13:59:57 -0500
In-Reply-To: <20180209173921.mtz55hgs5idj4vhk@linutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--------------84DD25CA1B744C070FAE6AF2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Sebastian

On 02/09/2018 11:39 AM, Sebastian Andrzej Siewior wrote:
> On 2018-02-06 09:47:15 [-0600], Dan Murphy wrote:
>> Sebastian
> Hi Dan,
> 
>> Agreed sorry for that.  I sent the issues before I got the mail list information.
> 
> You complained about two warnings. For number one I cherry-picked
> 15f7b41f70dd ("brd: remove unused brd_mutex"). 
> 

Great thanks.  I did see a LKML patch for this but it was old not sure if it was reposted or
reported to the list.

> The other thing was a warning in
> pl011_console_write::drivers/tty/serial/amba-pl011.c the flags member. I
> have here:
> 
>     CC      drivers/tty/serial/amba-pl011.o
> 
> with gcc version 7.3.0 (Debian 7.3.0-1). Looking at the code, flags is
> not be initialized in the uap->port.sysrq case but it is also not used.

I was using 7.2 gcc compiler distributed via Linaro.

> So it is a compiler thing and not a bug. There is the same pattern in
> the 8250 UART or the omap-serial driver. If you care enough to get this
> one fixed, please send a patch.

Hmmm I wonder why the compiler does not complain about this warning then.

I will look into it.  This warning has been around for a while (4.9-rt as well).

We also noticed that there are 2 merge conflicts when going to 4.14.18.
Any comments about providing a merge conflict email to the list?

Attached is the merge conflicts we are seeing 4.14.15-> 4.14.18

Dan

> 
> Sebastian
> 


-- 
------------------
Dan Murphy

--------------84DD25CA1B744C070FAE6AF2
Content-Type: text/plain; charset="UTF-8";
	name="linux_base_rt_merge_conflict.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux_base_rt_merge_conflict.txt"

ZGlmZiAtLWNjIGFyY2gveDg2L2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmgKaW5kZXggNDcy
MTY5MixlZGEzYjY4Li4wMDAwMDAwCi0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RocmVh
ZF9pbmZvLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaApAQEAg
LTU1LDggLTU1LDcgKzU1LDEyIEBAQCBzdHJ1Y3QgdGFza19zdHJ1Y3QKICAKICBzdHJ1Y3Qg
dGhyZWFkX2luZm8gewogIAl1bnNpZ25lZCBsb25nCQlmbGFnczsJCS8qIGxvdyBsZXZlbCBm
bGFncyAqLworKzw8PDw8PDwgSEVBRAogKwlpbnQgICAgICAgICAgICAgICAgICAgICBwcmVl
bXB0X2xhenlfY291bnQ7ICAgICAvKiAwID0+IGxhenkgcHJlZW1wdGFibGUKICsJCQkJCQkJ
ICAgPDAgPT4gQlVHICovCisrPT09PT09PQorIAl1MzIJCQlzdGF0dXM7CQkvKiB0aHJlYWQg
c3luY2hyb25vdXMgZmxhZ3MgKi8KKys+Pj4+Pj4+IGU5NDgzMGVmZTc1ODdlZDBiNzMzMzQx
OTM0YWNhNDA2ZWRlYWNjYzgKICB9OwogIAogICNkZWZpbmUgSU5JVF9USFJFQURfSU5GTyh0
c2spCQkJXApkaWZmIC0tY2Mga2VybmVsL3RpbWUvaHJ0aW1lci5jCmluZGV4IGZiMzQxM2Qs
MDUyNzczZC4uMDAwMDAwMAotLS0gYS9rZXJuZWwvdGltZS9ocnRpbWVyLmMKKysrIGIva2Vy
bmVsL3RpbWUvaHJ0aW1lci5jCkBAQCAtNjQ5LDMyIC01ODcsNzcgKzY0OSwzOSBAQEAgaHJ0
aW1lcl9mb3JjZV9yZXByb2dyYW0oc3RydWN0IGhydGltZXJfCiAgCXRpY2tfcHJvZ3JhbV9l
dmVudChjcHVfYmFzZS0+ZXhwaXJlc19uZXh0LCAxKTsKICB9CiAgCiArLyogSGlnaCByZXNv
bHV0aW9uIHRpbWVyIHJlbGF0ZWQgZnVuY3Rpb25zICovCiArI2lmZGVmIENPTkZJR19ISUdI
X1JFU19USU1FUlMKICsKICAvKgogLSAqIFdoZW4gYSB0aW1lciBpcyBlbnF1ZXVlZCBhbmQg
ZXhwaXJlcyBlYXJsaWVyIHRoYW4gdGhlIGFscmVhZHkgZW5xdWV1ZWQKIC0gKiB0aW1lcnMs
IHdlIGhhdmUgdG8gY2hlY2ssIHdoZXRoZXIgaXQgZXhwaXJlcyBlYXJsaWVyIHRoYW4gdGhl
IHRpbWVyIGZvcgogLSAqIHdoaWNoIHRoZSBjbG9jayBldmVudCBkZXZpY2Ugd2FzIGFybWVk
LgogLSAqCiAtICogQ2FsbGVkIHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZCBhbmQgYmFzZS0+
Y3B1X2Jhc2UubG9jayBoZWxkCiArICogSGlnaCByZXNvbHV0aW9uIHRpbWVyIGVuYWJsZWQg
PwogICAqLwogLXN0YXRpYyB2b2lkIGhydGltZXJfcmVwcm9ncmFtKHN0cnVjdCBocnRpbWVy
ICp0aW1lciwKIC0JCQkgICAgICBzdHJ1Y3QgaHJ0aW1lcl9jbG9ja19iYXNlICpiYXNlKQog
LXsKIC0Jc3RydWN0IGhydGltZXJfY3B1X2Jhc2UgKmNwdV9iYXNlID0gdGhpc19jcHVfcHRy
KCZocnRpbWVyX2Jhc2VzKTsKIC0Ja3RpbWVfdCBleHBpcmVzID0ga3RpbWVfc3ViKGhydGlt
ZXJfZ2V0X2V4cGlyZXModGltZXIpLCBiYXNlLT5vZmZzZXQpOwogLQogLQlXQVJOX09OX09O
Q0UoaHJ0aW1lcl9nZXRfZXhwaXJlc190djY0KHRpbWVyKSA8IDApOwogLQogLQkvKgogLQkg
KiBJZiB0aGUgdGltZXIgaXMgbm90IG9uIHRoZSBjdXJyZW50IGNwdSwgd2UgY2Fubm90IHJl
cHJvZ3JhbQogLQkgKiB0aGUgb3RoZXIgY3B1cyBjbG9jayBldmVudCBkZXZpY2UuCiAtCSAq
LwogLQlpZiAoYmFzZS0+Y3B1X2Jhc2UgIT0gY3B1X2Jhc2UpCiAtCQlyZXR1cm47CiAtCiAt
CS8qCiAtCSAqIElmIHRoZSBocnRpbWVyIGludGVycnVwdCBpcyBydW5uaW5nLCB0aGVuIGl0
IHdpbGwKIC0JICogcmVldmFsdWF0ZSB0aGUgY2xvY2sgYmFzZXMgYW5kIHJlcHJvZ3JhbSB0
aGUgY2xvY2sgZXZlbnQKIC0JICogZGV2aWNlLiBUaGUgY2FsbGJhY2tzIGFyZSBhbHdheXMg
ZXhlY3V0ZWQgaW4gaGFyZCBpbnRlcnJ1cHQKIC0JICogY29udGV4dCBzbyB3ZSBkb24ndCBu
ZWVkIGFuIGV4dHJhIGNoZWNrIGZvciBhIHJ1bm5pbmcKIC0JICogY2FsbGJhY2suCiAtCSAq
LwogLQlpZiAoY3B1X2Jhc2UtPmluX2hydGlycSkKIC0JCXJldHVybjsKIC0KIC0JLyoKIC0J
ICogQ0xPQ0tfUkVBTFRJTUUgdGltZXIgbWlnaHQgYmUgcmVxdWVzdGVkIHdpdGggYW4gYWJz
b2x1dGUKIC0JICogZXhwaXJ5IHRpbWUgd2hpY2ggaXMgbGVzcyB0aGFuIGJhc2UtPm9mZnNl
dC4gU2V0IGl0IHRvIDAuCiAtCSAqLwogLQlpZiAoZXhwaXJlcyA8IDApCiAtCQlleHBpcmVz
ID0gMDsKIC0KIC0JaWYgKGV4cGlyZXMgPj0gY3B1X2Jhc2UtPmV4cGlyZXNfbmV4dCkKIC0J
CXJldHVybjsKIC0KIC0JLyogVXBkYXRlIHRoZSBwb2ludGVyIHRvIHRoZSBuZXh0IGV4cGly
aW5nIHRpbWVyICovCiAtCWNwdV9iYXNlLT5uZXh0X3RpbWVyID0gdGltZXI7CiAtCiAtCS8q
CiAtCSAqIElmIGEgaGFuZyB3YXMgZGV0ZWN0ZWQgaW4gdGhlIGxhc3QgdGltZXIgaW50ZXJy
dXB0IHRoZW4gd2UKIC0JICogZG8gbm90IHNjaGVkdWxlIGEgdGltZXIgd2hpY2ggaXMgZWFy
bGllciB0aGFuIHRoZSBleHBpcnkKIC0JICogd2hpY2ggd2UgZW5mb3JjZWQgaW4gdGhlIGhh
bmcgZGV0ZWN0aW9uLiBXZSB3YW50IHRoZSBzeXN0ZW0KIC0JICogdG8gbWFrZSBwcm9ncmVz
cy4KIC0JICovCiAtCWlmIChjcHVfYmFzZS0+aGFuZ19kZXRlY3RlZCkKIC0JCXJldHVybjsK
ICtzdGF0aWMgYm9vbCBocnRpbWVyX2hyZXNfZW5hYmxlZCBfX3JlYWRfbW9zdGx5ICA9IHRy
dWU7CiArdW5zaWduZWQgaW50IGhydGltZXJfcmVzb2x1dGlvbiBfX3JlYWRfbW9zdGx5ID0g
TE9XX1JFU19OU0VDOwogK0VYUE9SVF9TWU1CT0xfR1BMKGhydGltZXJfcmVzb2x1dGlvbik7
CiAgCiAtCS8qCiAtCSAqIFByb2dyYW0gdGhlIHRpbWVyIGhhcmR3YXJlLiBXZSBlbmZvcmNl
IHRoZSBleHBpcnkgZm9yCiAtCSAqIGV2ZW50cyB3aGljaCBhcmUgYWxyZWFkeSBpbiB0aGUg
cGFzdC4KIC0JICovCiAtCWNwdV9iYXNlLT5leHBpcmVzX25leHQgPSBleHBpcmVzOwogLQl0
aWNrX3Byb2dyYW1fZXZlbnQoZXhwaXJlcywgMSk7CiArLyoKICsgKiBFbmFibGUgLyBEaXNh
YmxlIGhpZ2ggcmVzb2x1dGlvbiBtb2RlCiArICovCiArc3RhdGljIGludCBfX2luaXQgc2V0
dXBfaHJ0aW1lcl9ocmVzKGNoYXIgKnN0cikKICt7CiArCXJldHVybiAoa3N0cnRvYm9vbChz
dHIsICZocnRpbWVyX2hyZXNfZW5hYmxlZCkgPT0gMCk7CiAgfQogIAogK19fc2V0dXAoImhp
Z2hyZXM9Iiwgc2V0dXBfaHJ0aW1lcl9ocmVzKTsKICsKICAvKgogLSAqIEluaXRpYWxpemUg
dGhlIGhpZ2ggcmVzb2x1dGlvbiByZWxhdGVkIHBhcnRzIG9mIGNwdV9iYXNlCiArICogaHJ0
aW1lcl9oaWdoX3Jlc19lbmFibGVkIC0gcXVlcnksIGlmIHRoZSBoaWdocmVzIG1vZGUgaXMg
ZW5hYmxlZAogICAqLwogLXN0YXRpYyBpbmxpbmUgdm9pZCBocnRpbWVyX2luaXRfaHJlcyhz
dHJ1Y3QgaHJ0aW1lcl9jcHVfYmFzZSAqYmFzZSkKICtzdGF0aWMgaW5saW5lIGludCBocnRp
bWVyX2lzX2hyZXNfZW5hYmxlZCh2b2lkKQogIHsKKys8PDw8PDw8IEhFQUQKICsJcmV0dXJu
IGhydGltZXJfaHJlc19lbmFibGVkOworKz09PT09PT0KKyAJYmFzZS0+ZXhwaXJlc19uZXh0
ID0gS1RJTUVfTUFYOworIAliYXNlLT5oYW5nX2RldGVjdGVkID0gMDsKKyAJYmFzZS0+aHJl
c19hY3RpdmUgPSAwOworIAliYXNlLT5uZXh0X3RpbWVyID0gTlVMTDsKKys+Pj4+Pj4+IGU5
NDgzMGVmZTc1ODdlZDBiNzMzMzQxOTM0YWNhNDA2ZWRlYWNjYzgKICB9CiAgCiAgLyoKQEBA
IC0xOTAwLDEzIC0xNTkzLDkgKzE5MDcsMTQgQEBAIGludCBocnRpbWVyc19wcmVwYXJlX2Nw
dSh1bnNpZ25lZCBpbnQgYwogIAkJdGltZXJxdWV1ZV9pbml0X2hlYWQoJmNwdV9iYXNlLT5j
bG9ja19iYXNlW2ldLmFjdGl2ZSk7CiAgCX0KICAKKyAJY3B1X2Jhc2UtPmFjdGl2ZV9iYXNl
cyA9IDA7CiAgCWNwdV9iYXNlLT5jcHUgPSBjcHU7CiAtCWhydGltZXJfaW5pdF9ocmVzKGNw
dV9iYXNlKTsKICsJY3B1X2Jhc2UtPmhyZXNfYWN0aXZlID0gMDsKICsJY3B1X2Jhc2UtPmV4
cGlyZXNfbmV4dCA9IEtUSU1FX01BWDsKICsJY3B1X2Jhc2UtPnNvZnRpcnFfZXhwaXJlc19u
ZXh0ID0gS1RJTUVfTUFYOwogKyNpZmRlZiBDT05GSUdfUFJFRU1QVF9SVF9CQVNFCiArCWlu
aXRfd2FpdHF1ZXVlX2hlYWQoJmNwdV9iYXNlLT53YWl0KTsKICsjZW5kaWYKICAJcmV0dXJu
IDA7CiAgfQogIAo=
--------------84DD25CA1B744C070FAE6AF2--
