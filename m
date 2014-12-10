From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [PATCH] pip_stress: increase usleep for ARM devices
Date: Wed, 10 Dec 2014 13:00:54 +0300
Message-ID: <548819D6.3060507@pavlinux.ru>
References: <1418199901-3175-1-git-send-email-chase.qi@linaro.org>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: clark.williams@gmail.com, milosz.wasilewski@linaro.org,
	naresh.kamboju@linaro.org, jorge.ramirez-ortiz@linaro.org,
	anders.roxell@linaro.org, mike.holmes@linaro.org
To: chase.qi@linaro.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp03.mtu.ru ([62.5.255.20]:50185 "EHLO imp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbaLJKHz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Dec 2014 05:07:55 -0500
In-Reply-To: <1418199901-3175-1-git-send-email-chase.qi@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

May be #defines?

#ifndef (ARM)
		usleep(500);
#else
		usleep(3500);
#endif


10.12.2014 11:25, chase.qi@linaro.org =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> From: Chase Qi <chase.qi@linaro.org>
>
> Hello,
>
> pip_stress works out of the box on my x86 based laptop, but
> doesn't work on ARM devices, returned 'no inversion incurred'.
> Follow the comment to increase usleep value, 2500 worked for
> pandaboard and 3000 worked for Beaglebone Black board.
>
> I propose that increase the usleep value to 3500 from upstream,
> so that we can use pip_stress right out of the box.
>
> Please let me know if this is acceptable.
>
> Regards,
> Chase
>
> Signed-off-by: Chase Qi <chase.qi@linaro.org>
> ---
>   src/pi_tests/pip_stress.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> index 2b42b8f..553290b 100644
> --- a/src/pi_tests/pip_stress.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -162,7 +162,7 @@ void low(pid_t pid)
>   				statep->inversion =3D 0;
>   			}
>   		Pthread_mutex_unlock(statep->mutex);
> -		usleep(500);
> +		usleep(3500);
>   	Pthread_mutex_unlock(resource);
>   	waitpid(pid, &status, 0);
>   }
>


--=20

                                                          Pavel.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
