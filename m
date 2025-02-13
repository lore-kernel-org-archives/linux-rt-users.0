Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94643211A3E
	for <linux-rt-users@vger.kernel.org>; Thu, 13 Feb 2025 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739488165; cv=none; b=N1+hImVp3Ar3IIYLyYsjr5lPrkoBU7bOe1czlrYzTYj5Ia7dxlqcyOjnfHZ7JnUymf471p4HuPuGvQOu10whT4jOdwg5SILdyvOLaUmPl+9+6wa0S7aOWvlgZvyklyapLjvrAAd2eOtbodDr/7DFEgaekof1KnbBsBTl4LArcAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739488165; c=relaxed/simple;
	bh=hg3n1yq5zzhvUx2AVd3geRlibg9PTXkwrNwy7jwy4co=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fay3DMfX/2DLfr7xTcD3eAlYqim954+W255XB+a1BB6wyrjVwLjwQRO/gGRK7AGli9V45yn6OZOAWWYo2UlBfr6M0xYS5Em870po+fZiSgnTvEfO8tB0JBnpXgCoq3ApZ9trZo9GSaGoOpGfKtDbuAfbi5si81r6nX7OSjyGCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPq+N//J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPq+N//J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739488162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jiUxFAuPR7o7OhU2FrRk353wTBlKAT/Maz6z2Os6W68=;
	b=GPq+N//J7ESKW56ogcat6lCbT4wF+QcnquFTcy7zN2XWcIYDnfp4tWa+lkRG/mwQmCRh5S
	kGBRNIoCSCE0RWDzPencqMKF4M87J3ZpsGdXNWs9pcvxzMJWJ+UnUuO/OH64r8mlblgcSQ
	VIGG9Vhqc/GiblTMLazWYYW+QG6ZTnw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-XuRft9PNOSCXSZP0F0hxXw-1; Thu, 13 Feb 2025 18:09:21 -0500
X-MC-Unique: XuRft9PNOSCXSZP0F0hxXw-1
X-Mimecast-MFC-AGG-ID: XuRft9PNOSCXSZP0F0hxXw_1739488160
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e4565be110so16768306d6.2
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Feb 2025 15:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739488160; x=1740092960;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jiUxFAuPR7o7OhU2FrRk353wTBlKAT/Maz6z2Os6W68=;
        b=V4/odQ4FTmcJPoDBWyDDHNngzv0+K8cHrEqDjo4ilKOz2VjjJw/u5vWiiFGcXy+U8x
         5nPXwU1eaCAxGtqxV1iaXjpZcZVL1tv+bC+9WT/ND9Rl911RGa0KvbaX4xY9XHKTfyf+
         7L7mMoT9WlAs6RUgAM2YRJbIh+b2TayiqtLgynaNZCzutTwEFaVJa8lOwlIVWOQ3q/Ea
         Ngm4i4Z72d4CLghS06aik8UAyZsgxyP4owo5X7SyoGdtPFgwMZQBqufgMb7Ma/rSVPZr
         cOiAKIY4YzFxIG5CEN0fMA5U0p1OC8IbAyCGww9d3NpMzVvSvqOo+84p327QGxDONE20
         iT3Q==
X-Gm-Message-State: AOJu0Yx9M8xbwIQ3Sud6c0VQL0r7s9B0q84gTaMQ+EkEq50kjNGIcWu4
	9OW+iL3Lg3eSVr7XRSjJTqVl5V3QshXj4o1VNP3XsX58J5051mzrNfP5AfFCdhrkWd6JAXWthn5
	WHBxMsSBH9cdv3MYANINN6SasAjn2CR/1ERygOxfeqvPXKdBGXFUg0KJkGpD2rmKb
X-Gm-Gg: ASbGncte1TaSPXWTeUAG11o9Ij+Wc/s4Y0u0fDYXolWxWbr4cCoBKpOiD9mzlwOA8aE
	tzXKXwkGtF5sOgue9QasOv0eibQJw5nQdmVhFCPl66W4XdmDnq1DoUxgeDXF9YNvPTb/HOihM/q
	rgGf5EL2M2wDjP051rz8/mH0qKP4nwe5kUxMBgfSfBfNPUoqEI7Te/8oUQMt0QxPbv5NxTdr4BD
	5dftqDSls63A+CQKc9mPtJd63A3oNf9ZZ8YgiP7ZTv26ZOgjSmivHQ3JESo/5aGx8V+PvVNz4hP
	WPf6n7f9Oz92k4iLKIcm4qbwDDN37rBJtMW6
X-Received: by 2002:a05:6214:2683:b0:6e4:2d22:a566 with SMTP id 6a1803df08f44-6e46ed82877mr127960846d6.12.1739488160422;
        Thu, 13 Feb 2025 15:09:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDGBkOl9FF8/G/aaPbk+OhExcxUy3f5m6SYeCH+9jnGi59dfSqqhwnoa8MqaF73nkXxD4QPA==
X-Received: by 2002:a05:6214:2683:b0:6e4:2d22:a566 with SMTP id 6a1803df08f44-6e46ed82877mr127960506d6.12.1739488159869;
        Thu, 13 Feb 2025 15:09:19 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d779446sm14753466d6.1.2025.02.13.15.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:09:19 -0800 (PST)
Message-ID: <988719a1f124a548dc5c93fbce88dceaaa322e28.camel@redhat.com>
Subject: Re: [PATCH 2/2] tuna: Add idle-state control functionality
From: Crystal Wood <crwood@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Clark Williams
 <williams@redhat.com>,  John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, kernel-rts-sst
 <kernel-rts-sst@redhat.com>,  "John B. Wyatt IV" <sageofredondo@gmail.com>
Date: Thu, 13 Feb 2025 17:09:18 -0600
In-Reply-To: <20250128014551.15058-3-jwyatt@redhat.com>
References: <20250128014551.15058-1-jwyatt@redhat.com>
	 <20250128014551.15058-3-jwyatt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-27 at 20:45 -0500, John B. Wyatt IV wrote:
> Allows Tuna to control cpu idle-state functionality on the system,
> including querying, enabling, disabling of cpu idle-states to control
> power usage or to test functionality.
>=20
> This requires cpupower, a utility in the Linux kernel repository and
> the cpupower Python bindings added in Linux 6.12 to control cpu
> idle-states. If cpupower is missing Tuna as a whole will continue to
> function and idle-set functionality will error out.
>=20
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
>  tuna-cmd.py      |  33 +++++++-
>  tuna/cpupower.py | 202 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 233 insertions(+), 2 deletions(-)
>  create mode 100755 tuna/cpupower.py
>=20
> diff --git a/tuna-cmd.py b/tuna-cmd.py
> index d0323f5..81d0f48 100755
> --- a/tuna-cmd.py
> +++ b/tuna-cmd.py
> @@ -25,6 +25,7 @@ from tuna import tuna, sysfs, utils
>  import logging
>  import time
>  import shutil
> +import tuna.cpupower as cpw

>  def get_loglevel(level):
>      if level.isdigit() and int(level) in range(0,5):
> @@ -115,8 +116,12 @@ def gen_parser():
>              "disable_perf": dict(action=3D'store_true', help=3D"Explicit=
ly disable usage of perf in GUI for process view"),
>              "refresh": dict(default=3D2500, metavar=3D'MSEC', type=3Dint=
, help=3D"Refresh the GUI every MSEC milliseconds"),
>              "priority": dict(default=3D(None, None), metavar=3D"POLICY:R=
TPRIO", type=3Dtuna.get_policy_and_rtprio, help=3D"Set thread scheduler tun=
ables: POLICY and RTPRIO"),
> -            "background": dict(action=3D'store_true', help=3D"Run comman=
d as background task")
> -         }
> +            "background": dict(action=3D'store_true', help=3D"Run comman=
d as background task"),
> +            "idle_state_disabled_status": dict(dest=3D'idle_state_disabl=
ed_status', metavar=3D'IDLESTATEDISABLEDSTATUS', type=3Dint, help=3D'Print =
if cpu idle state of the cpus in CPU-LIST is enabled or disabled. If CPU-LI=
ST is not specified, default to all cpus.'),
> +            "idle_info": dict(dest=3D'idle_info', action=3D'store_const'=
, const=3DTrue, help=3D'Print general idle information on cpus in CPU-LIST.=
 If CPU-LIST is not specified, default to all cpus.'),
> +            "disable_idle_state": dict(dest=3D'disable_idle_state', meta=
var=3D'IDLESTATEINDEX', type=3Dint, help=3D'Disable cpus in CPU-LIST\'s cpu=
 idle (cpu sleep state). If CPU-LIST is not specified, default to all cpus.=
'),
> +            "enable_idle_state": dict(dest=3D'enable_idle_state', metava=
r=3D'IDLESTATEINDEX', type=3Dint, help=3D'Enable cpus in CPU-LIST\'s cpu id=
le (cpu sleep state). If CPU-LIST is not specified, default to all cpus.')
> +    }
> =20
>      parser =3D HelpMessageParser(description=3D"tuna - Application Tunin=
g Program")
> =20
> @@ -147,6 +152,10 @@ def gen_parser():
>      show_irqs =3D subparser.add_parser('show_irqs', description=3D'Show =
IRQ list', help=3D'Show IRQ list')
>      show_configs =3D subparser.add_parser('show_configs', description=3D=
'List preloaded profiles', help=3D'List preloaded profiles')
> =20
> +    idle_set =3D subparser.add_parser('idle-set',
> +                                    description=3D'Query and set all idl=
e states on a given CPU list. Requires libcpupower to be installed',
> +                                    help=3D'Set all idle states on a giv=
en CPU-LIST.')

idle_state would be a better name (or idle-state, but underscores are
already used elsewhere...), since it can both set and get.

It also mostly operates on individual states (-i being the exception),
not all at once.  How about just:

Manage CPU idle state disabling (requires libcpupower)

Also, don't forget to update the man page.

> @@ -635,6 +651,19 @@ def main():
>          my_logger.addHandler(add_handler("DEBUG", tofile=3DFalse))
>          my_logger.info("Debug option set")
> =20
> +    if args.command =3D=3D 'idle-set':
> +        if not cpw.have_cpupower:
> +            print(f"Error: libcpupower bindings are not detected; need {=
cpw.cpupower_required_kernel} at a minimum.")
> +            sys.exit(1)
> +
> +        if not args.cpu_list or args.cpu_list =3D=3D []:
> +            args.cpu_list =3D cpw.Cpupower().get_all_cpu_list()
> +
> +        my_cpupower =3D cpw.Cpupower(args.cpu_list)
> +        ret =3D my_cpupower.idle_state_handler(args)
> +        if ret > 0:
> +            sys.exit(ret)

Why not just pass in cpu_list as is, and have cpw understand what
an empty or absent list is?  And it looks like it already partially
does check for None...  If the user specifically does something
like --cpu '' should we really treat that as equivalent to not
specifing --cpu?  I don't see other commands doing this.

Especially if you're going to delegate all other option parsing...
Why is cpulist special?  Just do something like:

elif args.command =3D=3D 'idle_state'
    cpw.idle_state(args)

>      if args.loglevel:
>          if not args.debug:
>              my_logger =3D setup_logging("my_logger")

Why did you put the new command before log handling, rather than with
all the other commands?

> diff --git a/tuna/cpupower.py b/tuna/cpupower.py
> new file mode 100755
> index 0000000..b09dc2f
> --- /dev/null
> +++ b/tuna/cpupower.py
> @@ -0,0 +1,202 @@
> +# Copyright (C) 2024 John B. Wyatt IV
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +from typing import List
> +import tuna.utils as utils
> +
> +cpupower_required_kernel =3D "6.12"
> +have_cpupower =3D None
> +
> +
> +import raw_pylibcpupower as cpw

This is a bit confusing since you import this module as cpw
elsewhere...

Also, I got this even without trying to use the new functionality:

$ ./tuna-cmd.py=20
Traceback (most recent call last):
  File "/home/crwood/git/tuna/./tuna-cmd.py", line 28, in <module>
    import tuna.cpupower as cpw
  File "/home/crwood/git/tuna/tuna/cpupower.py", line 11, in <module>
    import raw_pylibcpupower as cpw
ModuleNotFoundError: No module named 'raw_pylibcpupower'

Maybe something like:

try:
    import raw_pylibcpupower as lcpw
    lcpw.cpufreq_get_available_frequencies(0)
except:
    lcpw =3D None

> +        You must use have_cpupower variable to determine if the bindings=
 were
> +        detected in your code."""

Instead of doing to the class/module user what SWIG did to the binding
user, why not just throw an exception if the binding is missing?  This
will automatically happen if lcpw is None, though you may want a
friendlier error message in the main entry point.

> +        def __init__(self, cpulist=3DNone):
> +            if cpulist =3D=3D None:
> +                self.__cpulist =3D self.get_all_cpu_list()
> +            else:
> +                self.__cpulist =3D cpulist
> +
> +        @classmethod
> +        def get_all_cpu_list(cls):
> +            return list(range(cls.get_idle_info()["all_cpus"]))

Is this really idle-state-specific?  Maybe just something like this
in tuna/utils.py:

def get_all_cpu_list():
    return list(range(get_nr_cpus()))

We shouldn't need to get all the idle state information just to get a
cpu list.

And all these class methods make me wonder why this is a class to begin
with, rather than just module functions.

> +
> +        @classmethod
> +        def get_idle_info(cls, cpu=3D0):

Why is cpu 0 special?

> +            idle_states, idle_states_amt =3D cls.get_idle_states(cpu)
> +            idle_states_list =3D []
> +            for idle_state in range(0, len(idle_states)):
> +                idle_states_list.append(
> +                    {
> +                        "CPU ID": cpu,
> +                        "Idle State Name": idle_states[idle_state],
> +                        "Flags/Description": cpw.cpuidle_state_desc(cpu,=
 idle_state),
> +                        "Latency": cpw.cpuidle_state_latency(cpu, idle_s=
tate),
> +                        "Usage": cpw.cpuidle_state_usage(cpu, idle_state=
),
> +                        "Duration": cpw.cpuidle_state_time(cpu, idle_sta=
te)
> +                    }
> +                )
> +            idle_info =3D {
> +                "all_cpus": utils.get_nr_cpus(),
> +                "CPUidle-driver": cpw.cpuidle_get_driver(),
> +                "CPUidle-governor": cpw.cpuidle_get_governor(),
> +                "idle-states-count": idle_states_amt,
> +                "available-idle-states": idle_states,
> +                "cpu-states": idle_states_list
> +            }
> +            return idle_info

This seems overly complicated.  Why do you bundle all this stuff up
just to extract it elsewhere?  The call to get the data is simpler than
the data structure lookup.

> +
> +        @classmethod
> +        def print_idle_info(cls, cpu_list=3D[0]):

The only thing that instantiating this class does is to store a cpu
list, and here you're passing it into a class method instead...

> +        def idle_state_handler(self, args) -> int:
> +            if args.idle_state_disabled_status !=3D None:
> +                cstate_index =3D args.idle_state_disabled_status
> +                cstate_list, cstate_amt =3D self.get_idle_states(args.cp=
u_list[0]) # Assumption, that all cpus have the same idle state

The API doesn't make that assumption, so why should we?  Systems exist
with heterogeneous CPUs... could be a reason to support looking up states
by name, if and when there are systems we care about that actually have
different cpuidle states.

And you don't need this lookup anyay -- libcpupower already does the
bounds check, and you can get the name inside the loop.

> +                if cstate_index < 0 or cstate_index >=3D cstate_amt:
> +                    print(f"Invalid idle state range. Total for this cpu=
 is {cstate_amt}")
> +                    return 1

"this cpu"?

> +                cstate_name =3D cstate_list[cstate_index]
> +                ret =3D self.is_disabled_idle_state(cstate_index)
> +                for i, e in enumerate(ret):
> +                    match e:
> +                        case 1:
> +                            print(f"CPU: {args.cpu_list[i]} Idle state \=
"{cstate_name}\" is disabled.")
> +                        case 0:
> +                            print(f"CPU: {args.cpu_list[i]} Idle state \=
"{cstate_name}\" is enabled.")
> +                        case -1:
> +                            print(f"Idlestate not available")
> +                        case -2:
> +                            print(f"Disabling is not supported by the ke=
rnel")
> +                        case _:
> +                            print(f"Not documented: {e}")
> +            elif args.idle_info !=3D None:
> +                self.print_idle_info(args.cpu_list)
> +                return 0
> +            elif args.disable_idle_state !=3D None:
> +                cstate_index =3D args.disable_idle_state
> +                cstate_list, cstate_amt =3D self.get_idle_states(args.cp=
u_list[0]) # Assumption, that all cpus have the same idle state
> +                if cstate_index < 0 or cstate_index >=3D cstate_amt:
> +                    print(f"Invalid idle state range. Total for this cpu=
 is {cstate_amt}")
> +                    return 1
> +                cstate_name =3D cstate_list[cstate_index]
> +                ret =3D self.disable_idle_state(cstate_index, 1)
> +                for i, e in enumerate(ret):
> +                    match e:
> +                        case 0:
> +                            print(f"CPU: {args.cpu_list[i]} Idle state \=
"{cstate_name}\" is disabled.")
> +                        case -1:
> +                            print(f"Idlestate not available")
> +                        case -2:
> +                            print(f"Disabling is not supported by the ke=
rnel")
> +                        case -3:
> +                            print(f"No write access to disable/enable C-=
states: try using sudo")
> +                        case _:
> +                            print(f"Not documented: {e}")
> +            elif args.enable_idle_state !=3D None:
> +                cstate_index =3D args.enable_idle_state
> +                cstate_list, cstate_amt =3D self.get_idle_states(args.cp=
u_list[0]) # Assumption, that all cpus have the same idle state
> +                if cstate_index < 0 or cstate_index >=3D cstate_amt:
> +                    print(f"Invalid idle state range. Total for this cpu=
 is {cstate_amt}")
> +                    return 1
> +                cstate_name =3D cstate_list[cstate_index]
> +                ret =3D self.disable_idle_state(cstate_index, 0)
> +                for i, e in enumerate(ret):
> +                    match e:
> +                        case 0:
> +                            print(f"CPU: {args.cpu_list[i]} Idle state \=
"{cstate_name}\" is enabled.")
> +                        case -1:
> +                            print(f"Idlestate not available")
> +                        case -2:
> +                            print(f"Disabling is not supported by the ke=
rnel")
> +                        case -3:
> +                            print(f"No write access to disable/enable C-=
states: try using sudo")
> +                        case _:
> +                            print(f"Not documented: {e}")

Factor out the error messages so they're not duplicated between
suboperations.  Actually, pretty much the whole thing is duplicated between
enable/disable...

Do we want to print anything at all on success?  It looks like tuna
generally follows the Unix philosophy of not doing so.

And the error messages are a bit vague... imagine running a script and
something deep inside it spits out "Disabling is not supported by the
kernel".  Disabling what?

> +            else:
> +                print(args)
> +                print("idle-set error: you should not get here!")

"you should not get here" is not a useful error message... jut throw
an exception.

-Crystal

