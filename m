From: "Hardik A Gohil (WMSC-HW)" <hardik@willowglen.asia>
Subject: Re: Network Issue
Date: Wed, 14 Sep 2016 15:51:28 +0800
Message-ID: <CAGiFfw64YmXt7-dRG-_UM+nZ9R8VznqThiWhDxMVJtXvnKBwSQ@mail.gmail.com>
References: <CAGiFfw4o2c1f=pR+gKkVYAoHQ7V8ywLXu-_g9ahWSZoAoSD7tA@mail.gmail.com>
 <20160908061920.msefkdj4nk3exzpr@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113f8a3435d5a8053c72ffbd
Cc: linux-rt-users@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36001 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762050AbcINHv5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Sep 2016 03:51:57 -0400
Received: by mail-it0-f46.google.com with SMTP id o3so32347038ita.1
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Sep 2016 00:51:56 -0700 (PDT)
In-Reply-To: <20160908061920.msefkdj4nk3exzpr@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--001a113f8a3435d5a8053c72ffbd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 8, 2016 at 2:19 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> On Thu, Sep 08, 2016 at 09:49:14AM +0800, Hardik A Gohil (WMSC-HW) wrote:
>> I am working on Linux 3.2.0.
>
> Wow, you're still developing on a kernel that is 4.5 years old and
> you're not even taking the stable updates.

since we did development with phyCORE-AM335x-PD13.1.2 which is using 3.2 ke=
rnel.
we have already completed production and it wont be a easy task to
shift to 4. series
>
>> We had a requirement to make Linux Real Time so using RT-PREEMPT
>> (patch-3.2-rt10.patch.bz2)
>
> Even if you stick to 3.2.x, there is 3.2.82-rt118.
>
>> We are facing a network hang issue while running the periodic task of 5 =
ms.
>>
>> cannot ping any more when task is running is ran for some time.
>>
>> I am using Timer fd protocol to achieve this.
>>
>> I would like to know if there is such know issue in this patch.
>>
>> Any help will be appreciated.
>
> I bet you won't find help here until you reproduce the issue with a
> recent kernel (currently there is v4.6.7-rt11) and show the code of your
> periodic task.

I am using iperf to transfer the data over network same problem of
network hang happens
cannot ping any more.

Attached code for rt task
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|



--=20
--=20
Regards,
Hardik A Gohil


WILLOWGLEN MSC BERHAD (462648-V)
 NO 17 JALAN 2/149B, TAMAN SRI ENDAH,
 BANDAR BARU SRI PETALING,
 57000 KUALA LUMPUR, MALAYSIA
 TEL +603 90571228  FAX +603 90571218
  WILLOWGLEN.COM.MY

--001a113f8a3435d5a8053c72ffbd
Content-Type: text/x-csrc; charset=US-ASCII; name="rttask.c"
Content-Disposition: attachment; filename="rttask.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_it2lytjy0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHRpbWUuaD4K
I2luY2x1ZGUgPHNjaGVkLmg+CiNpbmNsdWRlIDxzeXMvbW1hbi5oPgojaW5jbHVkZSA8c3RyaW5n
Lmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KCiNkZWZpbmUgTVlfUFJJT1JJVFkgKDk5KQoKc3RydWN0
IHBlcmlvZGljX2luZm8KewoJaW50IHRpbWVyX2ZkOwoJdW5zaWduZWQgbG9uZyBsb25nIHdha2V1
cHNfbWlzc2VkOwp9OwoKc3RhdGljIGludCBtYWtlX3BlcmlvZGljICh1bnNpZ25lZCBpbnQgcGVy
aW9kLCBzdHJ1Y3QgcGVyaW9kaWNfaW5mbyAqaW5mbykKewoJaW50IHJldDsKCXVuc2lnbmVkIGlu
dCBuczsKCXVuc2lnbmVkIGludCBzZWM7CglpbnQgZmQ7CglzdHJ1Y3QgaXRpbWVyc3BlYyBpdHZh
bDsKCgkvKiBDcmVhdGUgdGhlIHRpbWVyICovCglmZCA9IHRpbWVyZmRfY3JlYXRlIChDTE9DS19N
T05PVE9OSUMsIDApOwoJaW5mby0+d2FrZXVwc19taXNzZWQgPSAwOwoJaW5mby0+dGltZXJfZmQg
PSBmZDsKCWlmIChmZCA9PSAtMSkKCQlyZXR1cm4gZmQ7CgoJLyogTWFrZSB0aGUgdGltZXIgcGVy
aW9kaWMgKi8KCXNlYyA9IHBlcmlvZC8xMDAwMDAwOwoJbnMgPSAocGVyaW9kIC0gKHNlYyAqIDEw
MDAwMDApKSAqIDEwMDA7CglpdHZhbC5pdF9pbnRlcnZhbC50dl9zZWMgPSBzZWM7CglpdHZhbC5p
dF9pbnRlcnZhbC50dl9uc2VjID0gbnM7CglpdHZhbC5pdF92YWx1ZS50dl9zZWMgPSBzZWM7Cglp
dHZhbC5pdF92YWx1ZS50dl9uc2VjID0gbnM7CglyZXQgPSB0aW1lcmZkX3NldHRpbWUgKGZkLCAw
LCAmaXR2YWwsIE5VTEwpOwoJcmV0dXJuIHJldDsKfQoKc3RhdGljIHZvaWQgd2FpdF9wZXJpb2Qg
KHN0cnVjdCBwZXJpb2RpY19pbmZvICppbmZvKQp7Cgl1bnNpZ25lZCBsb25nIGxvbmcgbWlzc2Vk
OwoJaW50IHJldDsKCgkvKiBXYWl0IGZvciB0aGUgbmV4dCB0aW1lciBldmVudC4gSWYgd2UgaGF2
ZSBtaXNzZWQgYW55IHRoZQoJICAgbnVtYmVyIGlzIHdyaXR0ZW4gdG8gIm1pc3NlZCIgKi8KCXJl
dCA9IHJlYWQgKGluZm8tPnRpbWVyX2ZkLCAmbWlzc2VkLCBzaXplb2YgKG1pc3NlZCkpOwoJaWYg
KHJldCA9PSAtMSkKCXsKCQlwZXJyb3IgKCJyZWFkIHRpbWVyIik7CgkJcmV0dXJuOwoJfQoKCS8q
ICJtaXNzZWQiIHNob3VsZCBhbHdheXMgYmUgPj0gMSwgYnV0IGp1c3QgdG8gYmUgc3VyZSwgY2hl
Y2sgaXQgaXMgbm90IDAgYW55d2F5ICovCglpZiAobWlzc2VkID4gMCkKCQlpbmZvLT53YWtldXBz
X21pc3NlZCArPSAobWlzc2VkIC0gMSk7Cn0KCmludCBtYWluKHZvaWQpCnsKCXN0cnVjdCBwZXJp
b2RpY19pbmZvIGluZm87CglzdHJ1Y3Qgc2NoZWRfcGFyYW0gcGFyYW07CglzdHJ1Y3QgdGltZXZh
bCBzdG9wLCBzdGFydDsKCglwYXJhbS5zY2hlZF9wcmlvcml0eSA9IE1ZX1BSSU9SSVRZOwogICAg
ICAgIGlmKHNjaGVkX3NldHNjaGVkdWxlcigwLCBTQ0hFRF9GSUZPLCAmcGFyYW0pID09IC0xKSB7
CiAgICAgICAgICAgICAgICBwZXJyb3IoInNjaGVkX3NldHNjaGVkdWxlciBmYWlsZWQiKTsKICAg
ICAgICAgICAgICAgIGV4aXQoLTEpOwogICAgICAgIH0KCW1ha2VfcGVyaW9kaWMoNTAwMCwgJmlu
Zm8pOyAvLzEgc2VjIAoJd2hpbGUgKDEpCgl7CgkJLyogRG8gdXNlZnVsIHdvcmsgKi8KCQlwcmlu
dGYoIlRoaXMgaXMgcmVhbCB0aW1lIHRhc2siKTsKCQlnZXR0aW1lb2ZkYXkoJnN0YXJ0LCBOVUxM
KTsKCQl3YWl0X3BlcmlvZCAoJmluZm8pOwoJCWdldHRpbWVvZmRheSgmc3RvcCwgTlVMTCk7CgkJ
cHJpbnRmKCJ0b29rICVsdVxuIiwgc3RvcC50dl91c2VjIC0gc3RhcnQudHZfdXNlYyk7Cgl9Cgly
ZXR1cm4gMDsKfQo=
--001a113f8a3435d5a8053c72ffbd--
