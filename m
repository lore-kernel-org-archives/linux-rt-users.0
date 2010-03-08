From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/2] add-smp-option-to-ptsematest.patch
Date: Mon, 8 Mar 2010 13:45:27 +0100
Message-ID: <520f0cf11003080445i2733a309v3362fa217e542050@mail.gmail.com>
References: <20100307204800.456744470@osadl.org>
	 <20100307204907.464728076@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:2541 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab0CHMp2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Mar 2010 07:45:28 -0500
Received: by ey-out-2122.google.com with SMTP id 25so267152eya.5
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Mar 2010 04:45:27 -0800 (PST)
In-Reply-To: <20100307204907.464728076@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Mar 7, 2010 at 9:48 PM, Carsten Emde <C.Emde@osadl.org> wrote:
> Add SMP testing option (-S, --smp) to ptsematest, same as in
> cyclictest.
>
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>
> Index: rt-tests/src/ptsematest/ptsematest.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- rt-tests.orig/src/ptsematest/ptsematest.c
> +++ rt-tests/src/ptsematest/ptsematest.c
> @@ -173,6 +173,8 @@ static void display_help(void)
> =A0 =A0 =A0 =A0"-i INTV =A0--interval=3DINTV =A0 base interval of thr=
ead in us default=3D1000\n"
> =A0 =A0 =A0 =A0"-l LOOPS --loops=3DLOOPS =A0 =A0 number of loops: def=
ault=3D0(endless)\n"
> =A0 =A0 =A0 =A0"-p PRIO =A0--prio=3DPRIO =A0 =A0 =A0 priority\n"
> + =A0 =A0 =A0 "-S =A0 =A0 =A0 --smp =A0 =A0 =A0 =A0 =A0 =A0 SMP testi=
ng: options -a -t and same priority\n"
> + =A0 =A0 =A0 =A0" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 of all threads\n"
> =A0 =A0 =A0 =A0"-t =A0 =A0 =A0 --threads =A0 =A0 =A0 =A0 one thread p=
er available processor\n"
> =A0 =A0 =A0 =A0"-t [NUM] --threads=3DNUM =A0 =A0 number of threads:\n=
"
> =A0 =A0 =A0 =A0" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
without NUM, threads =3D max_cpus\n"
> @@ -189,6 +191,8 @@ static int num_threads =3D 1;
> =A0static int max_cycles;
> =A0static int interval =3D 1000;
> =A0static int distance =3D 500;
> +static int smp;
> +static int sameprio;
>
> =A0static void process_options (int argc, char *argv[])
> =A0{
> @@ -205,16 +209,21 @@ static void process_options (int argc, c
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{"interval", required_=
argument, NULL, 'i'},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{"loops", required_arg=
ument, NULL, 'l'},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{"priority", required_=
argument, NULL, 'p'},
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {"smp", no_argument, NU=
LL, 'S'},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{"threads", optional_a=
rgument, NULL, 't'},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{"help", no_argument, =
NULL, '?'},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{NULL, 0, NULL, 0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int c =3D getopt_long (argc, argv, "a::=
b:d:i:l:p:t::",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int c =3D getopt_long (argc, argv, "a::=
b:d:i:l:p:St::",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0long_options, &option_=
index);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (c =3D=3D -1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (c) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 'a':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (smp) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 warn("-=
a ignored due to --smp\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (optarg !=3D NULL) =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0affini=
ty =3D atoi(optarg);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setaff=
inity =3D AFFINITY_SPECIFIED;
> @@ -230,7 +239,16 @@ static void process_options (int argc, c
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 'i': interval =3D atoi(optarg); b=
reak;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 'l': max_cycles =3D atoi(optarg);=
 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 'p': priority =3D atoi(optarg); b=
reak;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 'S':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_threads =3D max_cpu=
s;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 setaffinity =3D AFFINIT=
Y_USEALL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 't':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (smp) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 warn("-=
t ignored due to --smp\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (optarg !=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0num_th=
reads =3D atoi(optarg);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (optind<argc &=
& atoi(argv[optind]))
> @@ -261,6 +279,9 @@ static void process_options (int argc, c
> =A0 =A0 =A0 =A0if (num_threads < 1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D 1;
>
> + =A0 =A0 =A0 if (priority && smp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sameprio =3D 1;
> +
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0display_help ();
> =A0}
> @@ -327,7 +348,7 @@ int main(int argc, char *argv[])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0receiver[i].priority =3D priority;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0receiver[i].tracelimit =3D tracelimit;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (priority > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (priority > 1 && !sameprio)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priority--;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0receiver[i].delay.tv_sec =3D interval =
/ USEC_PER_SEC;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0receiver[i].delay.tv_nsec =3D (interva=
l % USEC_PER_SEC) * 1000;
>
> --

Acked-by: John Kacur <jkacur@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
