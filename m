From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest: Set tracing_thresh optionally
Date: Wed, 27 Jan 2010 14:06:51 +0100
Message-ID: <520f0cf11001270506ge76cca1ha259539a101522c2@mail.gmail.com>
References: <a0e7fce51001270318q6f16aea1j765849bb09df8640@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: williams@redhat.com, tglx@linutronix.de,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: yi li <liyi.dev@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:38788 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311Ab0A0NGy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jan 2010 08:06:54 -0500
In-Reply-To: <a0e7fce51001270318q6f16aea1j765849bb09df8640@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jan 27, 2010 at 12:18 PM, yi li <liyi.dev@gmail.com> wrote:
> Hi,
>
> In cyclictest, by default "tracing_thresh" will be set to "tracelimit=
"
> (given to cyclictest with option "-b tracelimit").
> If the maximum latency of the tracer currently used is less than
> "tracelimit", no trace will be recorded.

So, can't you just set the tracing_thresh to your desired value with th=
e
-b tracelimit option?

Explain to me how cyclictest will behave if tracelimit and tracing_thre=
sh
are set to different values.

If you showed us two sets of outputs (with and without your option)
to show what setting tracing_thresh separately would achieve that
would be helpful.

>
> e.g:
> ./cyclictest -p 80 -t 1 -n -l 10000 -i 10000 -b 8000 -I -f
> If the "irqsoff" maximum latency is less than 8000,
> "/sys/kernel/debug/tracing/trace" will no contain valid "irqsoff"
> trace.
>
> This is not expected sometimes if e.g, the maximum latency of
> cyclictest is caused by wakeup, but I want to see the irqsoff latency=
=2E
> So I think it may be better to allow user set "tracing_thresh"
> optionally, by adding a "--tracing_thresh=3DTHRESH" option.
>
> Here is a simple patch to show the idea:
>
> Signed-off-by: yi.li@analog.com
>
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.=
c
> index ce4d911..c2f1c07 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -144,6 +144,7 @@ struct thread_stat {
>
> =A0static int shutdown;
> =A0static int tracelimit =3D 0;
> +static int tracing_thresh =3D 0;
> =A0static int ftrace =3D 0;
> =A0static int kernelversion;
> =A0static int verbose =3D 0;
> @@ -384,9 +385,11 @@ static void setup_tracer(void)
> =A0 =A0 =A0 =A0if (kernelversion =3D=3D KV_26_CURR) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char buffer[32];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int ret;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(buffer, "%d", tracelimit);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 setkernvar("tracing_thresh", buffer);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tracing_thresh > 0 && tracing_thres=
h <=3D tracelimit) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(buffer, "%d", t=
racing_thresh);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 setkernvar("tracing_thr=
esh", buffer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

Do you need an else part that sets tracing_thresh to tracelimit?


>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* ftrace_enabled is a sysctl variable=
 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fileprefix =3D procfileprefix;
> @@ -766,6 +769,7 @@ static void display_help(int error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 without -t default =3D 1\n"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "-T TRACE --tracer=3DTRACER =A0 set traci=
ng function\n"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0 =A0configured tracers: %s\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0"--tracing_thresh=3DTHRESH =A0 =A0set tr=
acing_thresh of current
> tracer to THRESH\n"

If you run your patch through checkpatch you'll get

ERROR: patch seems to be corrupt (line wrapped?)
#64: FILE: src/cyclictest/cyclictest.c:772:
tracer to THRESH\n"

And because of the above, I am unable to apply your patch
with git am

We don't follow all the kernel style recommendations in cyclictest
but we try to follow most of them. So please run your patch
through checkpatch and fix-up the warnings.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "-u =A0 =A0 =A0 --unbuffered =A0 =A0 =A0f=
orce unbuffered output for live
> processing\n"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "-v =A0 =A0 =A0 --verbose =A0 =A0 =A0 =A0=
 output values on stdout for statistics\n"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 format: n:c:v n=3Dtasknum c=3Dcount
> v=3Dvalue in us\n"
> @@ -896,6 +900,7 @@ static void process_options (int argc, char *argv=
[])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{"help", no_argument, =
NULL, '?'},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{"tracer", required_ar=
gument, NULL, 'T'},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{"traceopt", required_=
argument, NULL, 'O'},
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {"tracing_thresh", requ=
ired_argument, NULL, 1},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{"smp", no_argument, N=
ULL, 'S'},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{NULL, 0, NULL, 0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> @@ -972,6 +977,7 @@ static void process_options (int argc, char *argv=
[])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0use_nanosleep =3D MODE=
_CLOCK_NANOSLEEP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case '?': display_help(0); break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1 : tracing_thresh =3D atoi(optarg=
); break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
