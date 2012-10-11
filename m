From: =?UTF-8?Q?Andr=C3=A9_Bachmann?= <andrebachmann.dd@gmail.com>
Subject: Re: Using patch-3.2-rt10, kernel won't compile with CONFIG_PREEMPT_RT_FULL=y
Date: Thu, 11 Oct 2012 17:58:06 +0200
Message-ID: <CAOARjkM49dJaDT3x9uLZpqGSFD174MeN6ayp_7CWAxsRUJxTOw@mail.gmail.com>
References: <CAOARjkOT0ZndTxyvAq-Yj8QN6EJ5JnodGcfHq4XooHNPKRadXQ@mail.gmail.com>
	<CAP=VYLpUWqF5nztH-ZyC4v+GNYi997vVcZdJ_zpptmOJh4jYpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37799 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab2JKP6I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2012 11:58:08 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so8969499wib.1
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Oct 2012 08:58:07 -0700 (PDT)
In-Reply-To: <CAP=VYLpUWqF5nztH-ZyC4v+GNYi997vVcZdJ_zpptmOJh4jYpA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2012/10/11 Paul Gortmaker <paul.gortmaker@windriver.com>:
> On Thu, Oct 11, 2012 at 10:39 AM, Andr=C3=A9 Bachmann
> <andrebachmann.dd@gmail.com> wrote:
>> Hi all,
>>
>> here I have a TI Sitara AM335X with its latest SDK v05.05.00. I
>> installed it and I'm able to compile my kernels. Kernel 3.2.0 is
>> shipped with this SDK.
>>
>> However, I want to use the official RT patches from
>> http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/older/. Since
>> kernel 3.2.0 is delivered with this SDK, I chose
>> http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/older/patch-3=
=2E2-rt10.patch.bz2
>> as the correct patch. With it, I patched my kernel sources - no erro=
rs
>> here. After that, I checked if there are any problems by compiling
>> this patched kernel. No problems, my board still boots fine.
>>
>> Then I really wanted to use the new RT features, so I backed up the
>> default config file tisdk_am335x-evm_defconfig and changed the optio=
n
>> "CONFIG_PREEMPT_NONE=3Dy" to "CONFIG_PREEMPT_RT_FULL=3Dy". No furthe=
r
>> changes.
>>
>> If I now compile this, I get an error when compiling drivers/pwm/pwm=
=2Ec:
>>
>> ...
>> CC drivers/pwm/pwm.o
>> drivers/pwm/pwm.c: In function 'pwm_set_frequency':
>> drivers/pwm/pwm.c:291:2: error: expected expression before 'do'
>> make[3]: *** [drivers/pwm/pwm.o] Error 1
>> make[2]: *** [drivers/pwm] Error 2
>> make[1]: *** [drivers] Error 2
>> make[1]: Leaving directory
>> `/home/user/ti-sdk-am335x-evm-05.05.00.00/board-support/linux-3.2.0-=
psp04.06.00.08.sdk'
>> make: *** [linux] Error 2
>>
>> This is the function near this line in pwm.c:
>>
>> 282 int pwm_set_frequency(struct pwm_device *p, unsigned long freq)
>> 283 {
>> 284 struct pwm_config c;
>> 285
>> 286 if (!freq)
>> 287 return -EINVAL;
>> 288
>> 289 c.config_mask =3D BIT(PWM_CONFIG_PERIOD_TICKS),
>> 290 c.period_ticks =3D pwm_ns_to_ticks(p, (NSEC_PER_SEC / freq)),
>
> Nothing to do with RT.  Whoever coded up this pwm.c file (presumably
> a part of the non-upstream SDK?) should learn the difference between
> "," and ";" on the above two lines.
>
> Paul.
> --

Well I must be completely blind to miss this. Thank you! Now the
kernel compiles successfully.
But now the question arises: Why I don't get this error when not using
"CONFIG_PREEMPT_RT_FULL=3Dy"?

>
>> 291 spin_lock(&p->pwm_lock);
>> 292 p->period_ns =3D NSEC_PER_SEC / freq;
>> 293 spin_unlock(&p->pwm_lock);
>> 294 return pwm_config(p, &c);
>> 295 }
>> 296 EXPORT_SYMBOL(pwm_set_frequency);
>>
>> So the error seems to be related with the call of spin_lock, which
>> surely gets changed by the RT patch. Has anyone a hint for me? I'm
>> quite new to this matter... :(
>> I appreciate any help!
>>
>> Andr=C3=A9
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
