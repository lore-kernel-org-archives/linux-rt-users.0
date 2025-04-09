Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497E11E7C1C
	for <linux-rt-users@vger.kernel.org>; Wed,  9 Apr 2025 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235387; cv=none; b=YMExSxnTtnIL7JQzJpeh/0u6uvMp3Kj2TWFkLw/P5cPscRQmAzA1bcAJpY0knHPmTqkhMx+wcDPHosYUGvDs3OjP1ZXD+LXw/WotJ1g7n/qjkMAd00dUk0XE43NPP0BEX8UMk2HP/vgV8ANycoLcO4k3cFzQk/pFw5Afxg3+C2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235387; c=relaxed/simple;
	bh=e1zQGJei+ktNgIF13/+0zX7rjpQ41n/QH76uzb64TX0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Izx8QizIhztaFyzH0f49xCvxZXGXY5QojyT4JYgp2Yh0MpyeVEG/nIMb0RFTsQLR/eOvtPiiK0DlROPQIIQR0voiHgndg+mVJ9ftLx+hqruq8qCA3DId0Gol24ARaEIXKBeLaPmMTKDhAUJUxZtOFIOnGUNgkmK/9IN64ziVB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNDuB03z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNDuB03z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744235384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pXhY0Wa4EKDvmsj405cs/+1epWiCV/jx8gTt/FghYrQ=;
	b=JNDuB03zZL2FrEEJstHIppm3S1PcjSOFmZugvL37pWcqhpXBADEJTMCXL3nFY+anCp4RRs
	yh6Fz0NJWQ209OhHTE75HRVt7uP96MzHtALCouAkizli9PLwoJfLtOvVnFbbi8N3KTy6pC
	4I/wimQc0hE2opuGO7MQQwb4yUOE3VA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-NNcP3Cv9Mg2-SbJuogTu4Q-1; Wed, 09 Apr 2025 17:49:41 -0400
X-MC-Unique: NNcP3Cv9Mg2-SbJuogTu4Q-1
X-Mimecast-MFC-AGG-ID: NNcP3Cv9Mg2-SbJuogTu4Q_1744235381
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c543ab40d3so27214985a.2
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Apr 2025 14:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744235381; x=1744840181;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXhY0Wa4EKDvmsj405cs/+1epWiCV/jx8gTt/FghYrQ=;
        b=jYy/A+u3/d1ki967+gx9WCqJanHoF1C+bEpR0gzrO+poD33N/912Ybm3rgtcPzGcOq
         dTkg8f/ppeiEeiPKjrLP8kwLNN805VUKQAeD3/FAIZ745EZUHIQ0bdzDot5suXXOxW/e
         T8jsJnsEfoJRQudKvXbhVmTnI1yZRgY57mSFCpDtgxCZzbAYB7JsrhEOyLGuCaoeRECo
         gdRXrxzEgkDxikM0G6f73N+E6Y9SxMHMwauzEsBN8SDDt6WPQxFNekCWW3sHWsVyihiB
         DHxvPQRIh9cvH/7STRlaQGb3T/W+PWjSy9sKy7hHMdzquzsYSv6y4MmB+FeAcD//fkMN
         CpiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV3T/4U/p3TkeH/AhERdGTF5duXMJj0ouGJnoIbhjDvweRxzRAM6Cm8HmXAzSDa4SGjBJQvgg7Hwrg3XuH4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsVmgKvDoshamVV5FSdkQRg6jYdqc0z55NVBwkJ0ErwrNAH/Pt
	nYH2BpBFSuVqsIB62HauZBnqZJlwNh3e43wt8ytYSDNZ1xXAB5ZDPiweqfwGQ+fOlfBWiT9EyKT
	GU4Q/J808R9v3DlAYAzmOgd1WnMlDCyXAjZ7upRuxY+x8bfunXqG78Hl3gtXg0gvg
X-Gm-Gg: ASbGncuWoUdRl5KIGGmoXuPeI04nzth/pFuJehN+TnLVL8bYxYeAvJFyb4b7bxddIHw
	HBelzN8WH6WDuoTQuNMP7yEhmNVcNMp7Grl1ot4k9pHzpmpE6KR6G8syZh558Lj9M7Js1q3VPU/
	CvjJIwZZtSpLxj3YaJJIIbxULc3fFsf/GWcSYuSefYWE4JKYVRoiMPV6zp9uLKfeu7bms07thhi
	1O/2HmakXPSiLc/Wb3g2IE9Bc44vjvBwVC0exQE//Aya7jH4bKhPXmS9LIqwyqNl2jq81psD1nA
	ag==
X-Received: by 2002:a05:620a:4013:b0:7c5:4711:dc56 with SMTP id af79cd13be357-7c7a76cfdbfmr69685185a.48.1744235381346;
        Wed, 09 Apr 2025 14:49:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh8VcqcXApbqV6ffxsnLejM89vFG0Nf18tRBJm4eFt74DLwR5RSMl9Hwhd02jKq65mHW/vOw==
X-Received: by 2002:a05:620a:4013:b0:7c5:4711:dc56 with SMTP id af79cd13be357-7c7a76cfdbfmr69682085a.48.1744235380986;
        Wed, 09 Apr 2025 14:49:40 -0700 (PDT)
Received: from fionn ([142.189.102.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a10ba84csm121530785a.33.2025.04.09.14.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 14:49:40 -0700 (PDT)
Date: Wed, 9 Apr 2025 17:49:39 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Clark Williams <williams@redhat.com>, Crystal Wood <crwood@redhat.com>, 
    linux-rt-users@vger.kernel.org, kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v5 2/2] tuna: Add idle_state control functionality
In-Reply-To: <20250409193136.44411-3-jwyatt@redhat.com>
Message-ID: <5a93a8fc-90e3-727a-e8ce-85b4c01e7834@redhat.com>
References: <20250409193136.44411-1-jwyatt@redhat.com> <20250409193136.44411-3-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 9 Apr 2025, John B. Wyatt IV wrote:

> Allows Tuna to control cpu idle-state functionality on the system,
> including querying, enabling, disabling of cpu idle-states to control
> power usage or to test functionality.
> 
> This requires cpupower, a utility in the Linux kernel repository and
> the cpupower Python bindings added in Linux 6.12 to control cpu
> idle-states.
> 
> This patch revision includes text snippet & Python suggestions by Crystal
> Wood (v2-4) and small Python suggestions & code snippets by John Kacur
> (v3-5).
> 
> Suggested-by: John Kacur <jkacur@redhat.com>
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  tuna-cmd.py      |  30 +++++++-
>  tuna/cpupower.py | 177 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 204 insertions(+), 3 deletions(-)
>  create mode 100755 tuna/cpupower.py
> 
> diff --git a/tuna-cmd.py b/tuna-cmd.py
> index d0323f5..4997eaa 100755
> --- a/tuna-cmd.py
> +++ b/tuna-cmd.py
> @@ -25,6 +25,7 @@ from tuna import tuna, sysfs, utils
>  import logging
>  import time
>  import shutil
> +import tuna.cpupower as cpw
>  
>  def get_loglevel(level):
>      if level.isdigit() and int(level) in range(0,5):
> @@ -115,8 +116,12 @@ def gen_parser():
>              "disable_perf": dict(action='store_true', help="Explicitly disable usage of perf in GUI for process view"),
>              "refresh": dict(default=2500, metavar='MSEC', type=int, help="Refresh the GUI every MSEC milliseconds"),
>              "priority": dict(default=(None, None), metavar="POLICY:RTPRIO", type=tuna.get_policy_and_rtprio, help="Set thread scheduler tunables: POLICY and RTPRIO"),
> -            "background": dict(action='store_true', help="Run command as background task")
> -         }
> +            "background": dict(action='store_true', help="Run command as background task"),
> +            "idle_info": dict(dest='idle_info', action='store_const', const=True, help='Print general idle information for the selected CPUs, including index values for IDLE-STATE.'),
> +            "idle_state_disabled_status": dict(dest='idle_state_disabled_status', metavar='IDLE-STATE', type=int, help='Print whether IDLE-STATE is enabled on the selected CPUs.'),
> +            "disable_idle_state": dict(dest='disable_idle_state', metavar='IDLE-STATE', type=int, help='Disable IDLE-STATE on the selected CPUs.'),
> +            "enable_idle_state": dict(dest='enable_idle_state', metavar='IDLE-STATE', type=int, help='Enable IDLE-STATE on the selected CPUs.')
> +    }
>  
>      parser = HelpMessageParser(description="tuna - Application Tuning Program")
>  
> @@ -127,6 +132,9 @@ def gen_parser():
>  
>      subparser = parser.add_subparsers(dest='command')
>  
> +    idle_set = subparser.add_parser('cpu_power',
> +                                    description='Manage CPU idle state disabling (requires libcpupower and it\'s Python bindings)',
> +                                    help='Set all idle states on a given CPU-LIST.')
>      isolate = subparser.add_parser('isolate', description="Move all allowed threads and IRQs away from CPU-LIST",
>                                      help="Move all allowed threads and IRQs away from CPU-LIST")
>      include = subparser.add_parser('include', description="Allow all threads to run on CPU-LIST",
> @@ -146,7 +154,6 @@ def gen_parser():
>      show_threads = subparser.add_parser('show_threads', description='Show thread list', help='Show thread list')
>      show_irqs = subparser.add_parser('show_irqs', description='Show IRQ list', help='Show IRQ list')
>      show_configs = subparser.add_parser('show_configs', description='List preloaded profiles', help='List preloaded profiles')
> -
>      what_is = subparser.add_parser('what_is', description='Provides help about selected entities', help='Provides help about selected entities')
>      gui = subparser.add_parser('gui', description="Start the GUI", help="Start the GUI")
>  
> @@ -218,6 +225,13 @@ def gen_parser():
>      show_irqs_group.add_argument('-S', '--sockets', **MODS['sockets'])
>      show_irqs.add_argument('-q', '--irqs', **MODS['irqs'])
>  
> +    idle_set_group = idle_set.add_mutually_exclusive_group(required=True)
> +    idle_set_group.add_argument('-i', '--idle-info', **MODS['idle_info'])
> +    idle_set_group.add_argument('-s', '--status', **MODS['idle_state_disabled_status'])
> +    idle_set_group.add_argument('-d', '--disable', **MODS['disable_idle_state'])
> +    idle_set_group.add_argument('-e', '--enable', **MODS['enable_idle_state'])
> +    idle_set.add_argument('-c', '--cpus', **MODS['cpus'])
> +
>      what_is.add_argument('thread_list', **POS['thread_list'])
>  
>      gui.add_argument('-d', '--disable_perf', **MODS['disable_perf'])
> @@ -647,6 +661,16 @@ def main():
>              print("Valid log levels: NOTSET, DEBUG, INFO, WARNING, ERROR")
>              print("Log levels may be specified numerically (0-4)\n")
>  
> +    if args.command == 'cpu_power':
> +        if not cpw.have_cpupower:
> +            print(f"Error: libcpupower bindings are not detected; please install libcpupower bindings from at least kernel {cpw.cpupower_required_kernel}.", file=sys.stderr)
> +            sys.exit(1)
> +
> +        my_cpupower = cpw.Cpupower(args.cpu_list)
> +        ret = my_cpupower.idle_set_handler(args)
> +        if ret > 0:
> +            sys.exit(ret)
> +
>      if 'irq_list' in vars(args):
>          ps = procfs.pidstats()
>          if tuna.has_threaded_irqs(ps):
> diff --git a/tuna/cpupower.py b/tuna/cpupower.py
> new file mode 100755
> index 0000000..9a80f8e
> --- /dev/null
> +++ b/tuna/cpupower.py
> @@ -0,0 +1,177 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright (C) 2025 John B. Wyatt IV
> +
> +import sys
> +from typing import List
> +from tuna import utils
> +
> +cpupower_required_kernel = "6.12"
> +have_cpupower = None
> +
> +try:
> +    import raw_pylibcpupower as lcpw
> +    lcpw.cpufreq_get_available_frequencies(0)
> +    have_cpupower = True
> +except ImportError:
> +    lcpw = None
> +    have_cpupower = False
> +
> +if have_cpupower:
> +    class Cpupower:
> +        """The Cpupower class allows you to query and change the power states of the
> +        cpu.
> +
> +        You may query or change the cpus all at once or a list of the cpus provided to the constructor's cpulist argument.
> +
> +        The bindings must be detected on the $PYTHONPATH variable.
> +
> +        You must use have_cpupower variable to determine if the bindings were
> +        detected in your code."""
> +
> +        LCPW_ERROR_TWO_CASE = 1 # enum for common error messages
> +        LCPW_ERROR_THREE_CASE = 2
> +
> +        def __init__(self, cpu_list=None):
> +            if cpu_list and not cpu_list == []:
> +                self.__cpu_list = cpu_list
> +            else:
> +                self.__cpu_list = utils.get_all_cpu_list()
> +
> +        def handle_common_lcpw_errors(self, e, error_type, idle_name):
> +            match e:
> +                case 0:
> +                    pass
> +                case -1:
> +                    print(f"Idlestate {idle_name} not available", file=sys.stderr)
> +                case -2:
> +                    print("Disabling is not supported by the kernel", file=sys.stderr)
> +                case -3:
> +                    if error_type == Cpupower.LCPW_ERROR_THREE_CASE:
> +                        print("No write access to disable/enable C-states: try using sudo", file=sys.stderr)
> +                    else:
> +                        print(f"Not documented: {e}", file=sys.stderr)
> +                case _:
> +                    print(f"Not documented: {e}", file=sys.stderr)
> +
> +        def get_idle_states(self, cpu):
> +            """
> +            Get the c-states of a cpu.
> +
> +            You can capture the return values with:
> +            states_list, states_amt = get_idle_states()
> +
> +            Returns
> +                List[String]: list of cstates
> +                Int: amt of cstates
> +            """
> +            ret = []
> +            for cstate in range(lcpw.cpuidle_state_count(cpu)):
> +                ret.append(lcpw.cpuidle_state_name(cpu,cstate))
> +            return ret, lcpw.cpuidle_state_count(cpu)
> +
> +        def get_idle_info(self, cpu):
> +            idle_states, idle_states_amt = self.get_idle_states(cpu)
> +            idle_states_list = []
> +            for idle_state, idle_state_name in enumerate(idle_states):
> +                idle_states_list.append(
> +                    {
> +                        "CPU ID": cpu,
> +                        "Idle State Name": idle_state_name,
> +                        "Flags/Description": lcpw.cpuidle_state_desc(cpu, idle_state),
> +                        "Latency": lcpw.cpuidle_state_latency(cpu, idle_state),
> +                        "Usage": lcpw.cpuidle_state_usage(cpu, idle_state),
> +                        "Duration": lcpw.cpuidle_state_time(cpu, idle_state)
> +                    }
> +                )
> +            idle_info = {
> +                "CPUidle-driver": lcpw.cpuidle_get_driver(),
> +                "CPUidle-governor": lcpw.cpuidle_get_governor(),
> +                "idle-states-count": idle_states_amt,
> +                "available-idle-states": idle_states,
> +                "cpu-states": idle_states_list
> +            }
> +            return idle_info
> +
> +        def print_idle_info(self, cpu_list):
> +            for cpu in cpu_list:
> +                idle_info = self.get_idle_info(cpu)
> +                print(
> +f"""CPUidle driver: {idle_info["CPUidle-driver"]}
> +CPUidle governor: {idle_info["CPUidle-governor"]}
> +analyzing CPU {cpu}
> +
> +Number of idle states: {idle_info["idle-states-count"]}
> +Available idle states: {idle_info["available-idle-states"]}""")
> +                for state in idle_info["cpu-states"]:
> +                    print(
> +f"""{state["Idle State Name"]}
> +Flags/Description: {state["Flags/Description"]}
> +Latency: {state["Latency"]}
> +Usage: {state["Usage"]}
> +Duration: {state["Duration"]}""")
> +
> +        def idle_set_handler(self, args) -> int:
> +            if args.idle_state_disabled_status is not None:
> +                cstate_index = args.idle_state_disabled_status
> +                cstate_list, cstate_amt = self.get_idle_states(self.__cpu_list[0]) # Assuming all cpus have the same idle state
> +                if cstate_index < 0 or cstate_index >= cstate_amt:
> +                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}", file=sys.stderr)
> +                    return 1
> +                cstate_name = cstate_list[cstate_index]
> +                ret = self.is_disabled_idle_state(cstate_index)
> +                for i,e in enumerate(ret):
> +                    if e == 1:
> +                        print(f"CPU: {self.__cpu_list[i]} Idle state \"{cstate_name}\" is disabled.")
> +                    elif e == 0:
> +                        print(f"CPU: {self.__cpu_list[i]} Idle state \"{cstate_name}\" is enabled.")
> +                    else:
> +                        self.handle_common_lcpw_errors(e, self.LCPW_ERROR_TWO_CASE, cstate_name)
> +            elif args.idle_info is not None:
> +                self.print_idle_info(self.__cpu_list)
> +                return 0
> +            elif args.disable_idle_state is not None:
> +                cstate_index = args.disable_idle_state
> +                cstate_list, cstate_amt = self.get_idle_states(self.__cpu_list[0]) # Assuming all cpus have the same idle state
> +                if cstate_index < 0 or cstate_index >= cstate_amt:
> +                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}")
> +                    return 1
> +                cstate_name = cstate_list[cstate_index]
> +                ret = self.disable_idle_state(cstate_index, 1)
> +                for e in ret:
> +                    self.handle_common_lcpw_errors(e, self.LCPW_ERROR_THREE_CASE, cstate_name)
> +            elif args.enable_idle_state is not None:
> +                cstate_index = args.enable_idle_state
> +                cstate_list, cstate_amt = self.get_idle_states(self.__cpu_list[0]) # Assuming all cpus have the same idle state
> +                if cstate_index < 0 or cstate_index >= cstate_amt:
> +                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}")
> +                    return 1
> +                cstate_name = cstate_list[cstate_index]
> +                ret = self.disable_idle_state(cstate_index, 0)
> +                for e in ret:
> +                    self.handle_common_lcpw_errors(e, self.LCPW_ERROR_THREE_CASE, cstate_name)
> +            return 0
> +
> +        def disable_idle_state(self, state, disabled) -> List[int]:
> +            """
> +            Disable or enable an idle state using the object's stored list of cpus.
> +
> +            Args:
> +                state (int): The cpu idle state index to disable or enable as an int starting from 0.
> +                disabled (int): set to 1 to disable or 0 to enable. Less than 0 is an error.
> +            """
> +            ret = []
> +            for cpu in self.__cpu_list:
> +                ret.append(lcpw.cpuidle_state_disable(cpu, state, disabled))
> +            return ret
> +
> +        def is_disabled_idle_state(self, state) -> List[int]:
> +            """
> +            Query the idle state.
> +
> +            Args:
> +                state: The cpu idle state. 1 is disabled, 0 is enabled. Less than 0 is an error.
> +            """
> +            ret = []
> +            for cpu in self.__cpu_list:
> +                ret.append(lcpw.cpuidle_is_state_disabled(cpu, state))
> +            return ret
> -- 
> 2.49.0
> 
> 
> 

