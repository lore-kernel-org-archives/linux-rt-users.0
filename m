From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/2] add-smp-option-to-svsematest.patch
Date: Mon, 8 Mar 2010 13:45:59 +0100
Message-ID: <520f0cf11003080445h44fbd3a9l8dcbbdfb07483883@mail.gmail.com>
References: <20100307204800.456744470@osadl.org>
	 <20100307204909.626988443@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:40778 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab0CHMqB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Mar 2010 07:46:01 -0500
Received: by ewy8 with SMTP id 8so28079ewy.28
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Mar 2010 04:45:59 -0800 (PST)
In-Reply-To: <20100307204909.626988443@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Mar 7, 2010 at 9:48 PM, Carsten Emde <C.Emde@osadl.org> wrote:
> Add SMP testing option (-S, --smp) to svsematest, same as in
> cyclictest.
>
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>
> Index: rt-tests/src/svsematest/svsematest.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- rt-tests.orig/src/svsematest/svsematest.c
> +++ rt-tests/src/svsematest/svsematest.c
> @@ -248,6 +248,8 @@ static void display_help(void)
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
> @@ -263,6 +265,8 @@ static int num_threads =3D 1;
> =A0static int max_cycles;
> =A0static int interval =3D 1000;
> =A0static int distance =3D 500;
> +static int smp;
> +static int sameprio;
>
> =A0static void process_options (int argc, char *argv[])
> =A0{
> @@ -281,16 +285,21 @@ static void process_options (int argc, c
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
b:d:f::i:l:p:t::",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int c =3D getopt_long (argc, argv, "a::=
b:d:f::i:l:p:St::",
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
> @@ -317,7 +326,16 @@ static void process_options (int argc, c
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
> @@ -347,6 +365,9 @@ static void process_options (int argc, c
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (priority < 0 || priority > 99)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D 1;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (priority && smp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sameprio =3D 1;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tracelimit =3D thistracelimit;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (error)
> @@ -525,7 +546,7 @@ int main(int argc, char *argv[])
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
