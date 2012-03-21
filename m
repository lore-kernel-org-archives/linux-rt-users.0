From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 3/3] rt-tests: Remove unused status variable
Date: Wed, 21 Mar 2012 14:35:58 +0100
Message-ID: <CAONaPpE-C4W3v1hazzr-gw=4BRCEVuF+5crJCY1gi6N+syxZ_w@mail.gmail.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
	<c85461ecd2a73b044d01ec1880e583764e28492a.1332270303.git.dvhart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38259 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab2CUNf7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 09:35:59 -0400
Received: by dajr28 with SMTP id r28so1616388daj.19
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Mar 2012 06:35:58 -0700 (PDT)
In-Reply-To: <c85461ecd2a73b044d01ec1880e583764e28492a.1332270303.git.dvhart@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Mar 20, 2012 at 8:05 PM, Darren Hart <dvhart@linux.intel.com> w=
rote:
> The status variable is not used. Remove it and avoid the warning from=
 gcc.
>
> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
> CC: Clark Williams <williams@redhat.com>
> CC: John Kacur <jkacur@redhat.com>
> ---
> =A0src/pi_tests/pi_stress.c | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index 0940567..b89dec8 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -596,10 +596,9 @@ void *reporter(void *arg)
>
> =A0int verify_cpu(int cpu)
> =A0{
> - =A0 =A0 =A0 int status;
> =A0 =A0 =A0 =A0cpu_set_t mask;
>
> - =A0 =A0 =A0 status =3D sched_getaffinity(0, sizeof(cpu_set_t), &mas=
k);
> + =A0 =A0 =A0 sched_getaffinity(0, sizeof(cpu_set_t), &mask);
>
> =A0 =A0 =A0 =A0if (CPU_ISSET(cpu, &mask))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return SUCCESS;
> --

Don't you think it would be smarter to test the return status of
sched_getaffinity, than to shut-up the warning by removing the status
variable? I say we leave the variable in to remind us that we're not
finished.

Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
