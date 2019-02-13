From: Pintu Agarwal <pintu.ping@gmail.com>
Subject: Re: BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:65
Date: Wed, 13 Feb 2019 20:10:55 +0530
Message-ID: <CAOuPNLgUvECE6XBjszFggY3efmEBKywzKNWupjfQ2svsCMqd7w@mail.gmail.com>
References: <CAOuPNLgaDJm27nECxq1jtny=+ixt=GPf2C7zyDsVgbsLvtDarA@mail.gmail.com>
 <6183c865-2e90-5fb9-9e10-1339ae491b71@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, linux-mm@kvack.org,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        "Xenomai@xenomai.org" <xenomai@xenomai.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6183c865-2e90-5fb9-9e10-1339ae491b71@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Feb 13, 2019 at 3:21 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Pintu,
>
> On 2/13/2019 2:04 PM, Pintu Agarwal wrote:
> >
> > This is the complete logs at the time of crash:
> >
> > [   21.681020] VFS: Mounted root (ext4 filesystem) readonly on device 8:6.
> > [   21.690441] devtmpfs: mounted
> > [   21.702517] Freeing unused kernel memory: 6528K
> > [   21.766665] BUG: sleeping function called from invalid context at
> > kernel/locking/rwsem.c:65
> > [   21.775108] in_atomic(): 0, irqs_disabled(): 128, pid: 1, name: init
> > [   21.781532] ------------[ cut here ]------------
> > [   21.786209] kernel BUG at kernel/sched/core.c:8490!
> > [   21.791157] ------------[ cut here ]------------
> > [   21.795831] kernel BUG at kernel/sched/core.c:8490!
> > [   21.800763] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > [   21.806319] Modules linked in:
> > [   21.809474] CPU: 0 PID: 1 Comm: init Not tainted 4.9.103+ #115
> > [   21.815375] Hardware name: Qualcomm Technologies, Inc. MSM XXXX
> > [   21.822584] task: ffffffe330440080 task.stack: ffffffe330448000
> > [   21.828584] PC is at ___might_sleep+0x140/0x188
> > [   21.833175] LR is at ___might_sleep+0x128/0x188
> > [   21.837759] pc : [<ffffff88b8ce65a8>] lr : [<ffffff88b8ce6590>]
> > pstate: 604001c5
>
> <snip...>
>
> > 0000000000000000 ffffffe33044b8d0
> > [   22.135279] bac0: 0000000000000462 0000000000000006
> > [   22.140224] [<ffffff88b8ce65a8>] ___might_sleep+0x140/0x188
> > [   22.145862] [<ffffff88b8ce6648>] __might_sleep+0x58/0x90
> > [   22.151249] [<ffffff88b9d43f84>] down_write_killable+0x2c/0x80
> > [   22.157155] [<ffffff88b8e53cd8>] setup_arg_pages+0xb8/0x208
> > [   22.162792] [<ffffff88b8eb7534>] load_elf_binary+0x434/0x1298
> > [   22.168600] [<ffffff88b8e55674>] search_binary_handler+0xac/0x1f0
> > [   22.174763] [<ffffff88b8e560ec>] do_execveat_common.isra.15+0x504/0x6c8
> > [   22.181452] [<ffffff88b8e562f4>] do_execve+0x44/0x58
> > [   22.186481] [<ffffff88b8c84030>] run_init_process+0x38/0x48
> > [   22.192122] [<ffffff88b9d3db1c>] kernel_init+0x8c/0x108
> > [   22.197411] [<ffffff88b8c83f00>] ret_from_fork+0x10/0x50
> > [   22.202790] Code: b9453800 0b000020 6b00027f 540000c1 (d4210000)
> > [   22.208965] ---[ end trace d775a851176a61ec ]---
> > [   22.220051] Kernel panic - not syncing: Attempted to kill init!
> > exitcode=0x0000000b
> >
>
> This might be the work of CONFIG_PANIC_ON_SCHED_BUG which is extra debug
> option enabled in *sdm845_defconfig*. You can disable it or better
> I would suggest to use *sdm845-perf_defconfig* instead of
> sdm845_defconfig since there are a lot of debug options enabled
> in the latter which may be not compatible when IPIPE patches
> are applied.

OK thanks for your suggestions. sdm845-perf_defconfig did not work for
me. The target did not boot.
However, disabling CONFIG_PANIC_ON_SCHED_BUG works, and I got a root
shell at least.
This at least proves that there is no issue in core ipipe patches, and
I can proceed.

But this seems to be a work around.
I still get a back trace in kernel logs from many different places.
So, it looks like there is some code in qualcomm specific drivers that
is calling a sleeping method from invalid context.
How to find that...
If this fix is already available in latest version, please let me know.

Thanks,
Pintu
