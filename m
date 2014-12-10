From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH] pip_stress: increase usleep for ARM devices
Date: Wed, 10 Dec 2014 09:15:00 -0500
Message-ID: <54885564.2050904@linaro.org>
References: <1418199901-3175-1-git-send-email-chase.qi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: clark.williams@gmail.com, milosz.wasilewski@linaro.org,
	naresh.kamboju@linaro.org, anders.roxell@linaro.org,
	mike.holmes@linaro.org
To: chase.qi@linaro.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:56035 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972AbaLJOPD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Dec 2014 09:15:03 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so2193691qcv.15
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Dec 2014 06:15:01 -0800 (PST)
In-Reply-To: <1418199901-3175-1-git-send-email-chase.qi@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/10/2014 03:25 AM, chase.qi@linaro.org wrote:
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

I think they should have modified main() to accept the lock time as a parameter
instead of simply adding some instructions in the comments

 * to show that it works. If you are having difficulty triggering an inversion,
 * merely increase the time that the low priority process sleeps while
 * holding the lock. (usleep);
 * Also note that you have to run as a user with permission to change
 * scheduling priorities.
 */

what I would do is actually
1. modify main to accept lock_time
2. send the patch to the rt-tests team




>
> Regards,
> Chase
>
> Signed-off-by: Chase Qi <chase.qi@linaro.org>
> ---
>  src/pi_tests/pip_stress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> index 2b42b8f..553290b 100644
> --- a/src/pi_tests/pip_stress.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -162,7 +162,7 @@ void low(pid_t pid)
>  				statep->inversion = 0;
>  			}
>  		Pthread_mutex_unlock(statep->mutex);
> -		usleep(500);
> +		usleep(3500);
>  	Pthread_mutex_unlock(resource);
>  	waitpid(pid, &status, 0);
>  }

