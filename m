From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/locking/rwsem.c:65
Date: Thu, 14 Feb 2019 00:14:28 +0530
Message-ID: <2c91af7d-4580-cedc-70ea-d38c2587c7bf@codeaurora.org>
References: <CAOuPNLgaDJm27nECxq1jtny=+ixt=GPf2C7zyDsVgbsLvtDarA@mail.gmail.com>
 <6183c865-2e90-5fb9-9e10-1339ae491b71@codeaurora.org>
 <CAOuPNLgUvECE6XBjszFggY3efmEBKywzKNWupjfQ2svsCMqd7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, linux-mm@kvack.org,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        "Xenomai@xenomai.org" <xenomai@xenomai.org>
To: Pintu Agarwal <pintu.ping@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOuPNLgUvECE6XBjszFggY3efmEBKywzKNWupjfQ2svsCMqd7w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

On 2/13/2019 8:10 PM, Pintu Agarwal wrote:
> OK thanks for your suggestions. sdm845-perf_defconfig did not work for
> me. The target did not boot.

Perf defconfig works fine. You need to enable serial console with below
config added to perf defconfig.

CONFIG_SERIAL_MSM_GENI_CONSOLE=y

> However, disabling CONFIG_PANIC_ON_SCHED_BUG works, and I got a root
> shell at least.

> 
> But this seems to be a work around.
> I still get a back trace in kernel logs from many different places.
> So, it looks like there is some code in qualcomm specific drivers that
> is calling a sleeping method from invalid context.
> How to find that...
> If this fix is already available in latest version, please let me know.
> 

Seems like interrupts are disabled when down_write_killable() is called.
It's not the drivers that is calling the sleeping method which can  be
seen from the log.

[   22.140224] [<ffffff88b8ce65a8>] ___might_sleep+0x140/0x188
[   22.145862] [<ffffff88b8ce6648>] __might_sleep+0x58/0x90         <---
[   22.151249] [<ffffff88b9d43f84>] down_write_killable+0x2c/0x80   <---
[   22.157155] [<ffffff88b8e53cd8>] setup_arg_pages+0xb8/0x208      <---
[   22.162792] [<ffffff88b8eb7534>] load_elf_binary+0x434/0x1298
[   22.168600] [<ffffff88b8e55674>] search_binary_handler+0xac/0x1f0
[   22.174763] [<ffffff88b8e560ec>]
do_execveat_common.isra.15+0x504/0x6c8
[   22.181452] [<ffffff88b8e562f4>] do_execve+0x44/0x58
[   22.186481] [<ffffff88b8c84030>] run_init_process+0x38/0x48      <---
[   22.192122] [<ffffff88b9d3db1c>] kernel_init+0x8c/0x108
[   22.197411] [<ffffff88b8c83f00>] ret_from_fork+0x10/0x50

 >
 > This at least proves that there is no issue in core ipipe patches, and
 > I can proceed.

I doubt the *IPIPE patches*. You said you removed the configs, but all
code are not under IPIPE configs and as I see there are lots of
changes to interrupt code in general with ipipe.

So to actually confirm whether the issue is with qcom drivers or ipipe,
please *remove ipipe patches (not just configs)* and boot.
Also paste the full dmesg logs for these 2 cases(with and without
ipipe).

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
