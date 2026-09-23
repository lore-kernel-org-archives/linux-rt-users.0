Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5EA36B054
	for <linux-rt-users@vger.kernel.org>; Wed, 23 Sep 2026 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179357; cv=none; b=DroDAAjA/FHGkNAPS7c1KXyGxyaUE2tzr4QSbcB+LDYbUtzg0A4yX7HdEtNHXoHpL0gcM2MmnkexQAI1Z6CZ9Tgv68/B9by1Rxs7fvCcI1XfJozHtwfH54vumpopWV8wS4eTU0liqOUgJ0ecULotOl6z7q95Av97AIM+wXi4b68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179357; c=relaxed/simple;
	bh=BcTb5LfmS2cff7WMeaiqbJ4U4kNxqcL6Unw6Z5zIKVY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D2htm2iTU++aZDX8JgkwL/RIxorkB4WPOvgzYY2/McETqevRaDw2fTDVGQYDUot6xH8CT3rAmk2aDmv/vMd+g127Bf8ubb03q6fkWmp0+C1X57N35A0XDw2ufVkJqrUVmN3gk4dDd4KmgrkmET0oBWEN5tLJFmIJMHk1euJD+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPI6zoFE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPI6zoFE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790179354;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1WAOc9AA2Yc8WDlUvVDLHNs1qY88CDiVZBARD3gaiVM=;
	b=NPI6zoFEVnHkQFYiqz+gbCH2RMaVIoSwALRWC1uOCB9pJUnXTKdMNZBFfpfWEPgsIO5CWr
	oveL8beuFj52SoInvFtBNzdQbWBG7rTg6rAbPiuNuElGl+AQB+dVPaQYw1fbbYRemSz4pI
	nr6hJcBJNOYZ/9fAgrM1+hxLOhcQYuQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-8ODqfmZeMvOi4dUjeqDqeQ-1; Wed,
 23 Sep 2026 12:02:33 -0400
X-MC-Unique: 8ODqfmZeMvOi4dUjeqDqeQ-1
X-Mimecast-MFC-AGG-ID: 8ODqfmZeMvOi4dUjeqDqeQ_1790179352
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 398A01954AC8
	for <linux-rt-users@vger.kernel.org>; Wed, 23 Sep 2026 16:02:32 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE67A3000218;
	Wed, 23 Sep 2026 16:02:31 +0000 (UTC)
Date: Wed, 23 Sep 2026 12:02:31 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: williams@redhat.com
Cc: williams@redhat.com, vkuznets@redhat.com, 
	linux-rt-users@vger.kernel.org
Subject: Console Hang on SMP Secondary CPU Bringup
Message-ID: <arPmYPbFLf2EldIl@debarbos-thinkpadt14gen5.rmtusma.csb>
Reply-To: debarbos@redhat.com
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

TLDR: In v6.6-rt-rebase booting a kernel in a paravirtualized VM environment can
result in hangs in the early smp/smpboot secondary CPU bringup.

Hello,

In the v6.6-rt-rebase branch in the linux-stable-rt kernel trees, building (with
defconfig and additional HV drivers enabled), installing, then booting a kernel
in a paravirtualized Virtual Machine environment (HyperV in this case) via UEFI
boot may result in a unrecoverable "hang"

<snip>
[    0.644309] smpboot: CPU0: Intel(R) Xeon(R) Platinum 8171M CPU @ 2.60GHz (family: 0x6, model: 0x55, stepping: 0x4)
[    0.644565] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.
[    0.645350] signal: max sigframe size: 3632
[    0.646414] rcu: Hierarchical SRCU implementation.
[    0.646417] rcu:     Max phase no-delay instances is 400.
[    0.652387] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.653406] smp: Bringing up secondary CPUs ...
</snip>

which is only recoverable via rebooting the VM (and hoping that it doesn't hang
again).

The issue is most reliably reproduced on smaller systems with a high enough
loglevel (in this case, it reproduces most reliably with 8 in the cmdline). In
my testing so far, 2vCPUs with 8GiB of memory have a fairly high "hit rate" of
~30% with the following reproducer:

$ for f in `seq 1 50`; do echo try $f; ssh $VM_IP sudo reboot; sleep 90s; done

a reboot script attached to a systemd timer/service also suffices.

In any case, the system is completely unresponsive over the any serial consoles,
responding to neither SysRQs nor NMIs, even with the appropriate cmdline
arguments to invoke such behavior.

It appears as though the behavior in question has been bisected to af3a8162581e
("serial: 8250: Switch to nbcon console")

<snip>
$ git describe --contains af3a8162581e

v6.6.156-rt79-rebase~63

$ git show v6.6.156-rt79
</snip>

and is not reproducible prior to this point (it has not been bisectable to any
HV/HyperV/Xen/etc commits _yet_).

IIRC, this commit was reverted in mainline for the time being, as a significant
amount of work was/is being done in tty/serial, etc...

It is not entirely clear what effect the commit introduces with regard to the
smp secondary CPU masking/bringup, and why it would cause a
seemingly-unrecoverable state prior to the cpuhp callbacks.

IIUC (and from what I have seen in the traces) at this point in the init
process, we've disabled earlycon/earlyserial, and have brought up nbcon.

<snip>
void start_kernel(void)
{
    ...

	/*
	 * HACK ALERT! This is early. We're enabling the console before
	 * we've done PCI setups etc, and console_init() must be aware of
	 * this. But we do want output early, in case something goes wrong.
	 */
	console_init();
	if (panic_later)
		panic("Too many boot %s vars at `%s'", panic_later,
		      panic_param);

	lockdep_init();

	/*
	 * Need to run this when irqs are enabled, because it wants
	 * to self-test [hard/soft]-irqs on/off lock inversion bugs
	 * too:
	 */
	locking_selftest();

	/* Do the rest non-__init'ed, we're now alive */
	arch_call_rest_init();
</snip>

it is only then that rest_init() is called, which

<snip>
void __init __weak __noreturn arch_call_rest_init(void)
{
	rest_init();
}

...

noinline void __ref __noreturn rest_init(void)
{
	struct task_struct *tsk;
	int pid;

	rcu_scheduler_starting();
	/*
	 * We need to spawn init first so that it obtains pid 1, however
	 * the init task will end up wanting to create kthreads, which, if
	 * we schedule it before we create kthreadd, will OOPS.
	 */
	pid = user_mode_thread(kernel_init, NULL, CLONE_FS);

...

static noinline void __init kernel_init_freeable(void)
{
	/* Now the scheduler is fully set up and can do blocking allocations */
	gfp_allowed_mask = __GFP_BITS_MASK;

	/*
	 * init can allocate pages on any node
	 */
	set_mems_allowed(node_states[N_MEMORY]);

	cad_pid = get_pid(task_pid(current));

	smp_prepare_cpus(setup_max_cpus);

	workqueue_init();

	init_mm_internals();

	rcu_init_tasks_generic();
	do_pre_smp_initcalls();
	lockup_detector_init();

	smp_init(); ## INIT secondary CPUS HERE

...
</snip>

I have seen in some cases where nbcon 8250 can be slightly slower at boot time,
which could introduce the possibility of some contention between the increased
console verbosity and replacement of send_IPI_all/self() with
hv_send_ipi_all/self() (this is just conjecturing).

I am unsure what the precise interaction between the console (at this stage of
the init) and smp/smpboot secondary CPU bringup is.

I went and added a few pr_info()'s (I am still hacking on a system with
tracefs and trace_printk setup for more info) and was able to retrieve the
following from the serial console prior to hanging:

<snip>
[    0.705259] smp: bringing up secondary cpus ...
[    0.705267] parallel true!
[    0.705271] smpboot: parallel cpu startup enabled: 0x80000000
[    0.705278] masks: smt_max=2 present=0-1 primary=0 first_present=0 first_primary=0
[    0.705285] primary block kick: tmp=0 ncpus=8192
[    0.705290] in cpuhp_bringup_mask, still alive before iterator macro.
[    0.705295] in cpu 0. ncpus: 8192 
[    0.712205] in cpuhp_bringup_mask, still alive before iterator macro.
[    0.712212] in cpu 0. ncpus: 8192 
[    0.714186] secondary block kick: tmp=0 ncpus=8191
[    0.714193] still alive before 2nd bringup_mask
[    0.714195] in cpuhp_bringup_mask, still alive before iterator macro.
[    0.714212] in cpu 1. ncpus: 8191 
[    0.718185] cpuhp up cpu1 state threads:prepare (1)
[    0.719271] cpuhp up cpu1 state perf:prepare (2)
[    0.720186] cpuhp up cpu1 state mm/page_alloc:pcp (33)
[    0.721184] cpuhp up cpu1 state random:prepare (40)
[    0.721191] cpuhp up cpu1 state workqueue:prepare (41)
[    0.723239] cpuhp up cpu1 state hrtimers:prepare (43)
[    0.723246] cpuhp up cpu1 state smpcfd:prepare (46)
[    0.725187] cpuhp up cpu1 state relay:prepare (47)
[    0.726183] cpuhp up cpu1 state rcu/tree:prepare (50)
[    0.726189] cpuhp up cpu1 state trace/rb:prepare (62)
[    0.728189] cpuhp up cpu1 state timers:prepare (68)
[    0.728206] cpuhp up cpu1 state cpu:kick_ap (91)
[    0.728213] smpboot: ++++++++++++++++++++=_---cpu up  1
[    0.728218] smpboot: still allive before mtrr_save_state
[    0.728221] getting cpumask in mtrr_save_state ### HANG HERE
</snip>

jumping down the rabbit-hole of cpuhp_bp_*_ap:

cpuhp_bringup_mask(mask, ncpus, CPUHP_BP_KICK_AP) kernel/cpu.c
└─ for_each_cpu(cpu, mask)
   └─ cpu_up(cpu, CPUHP_BP_KICK_AP)
      ├─ try_online_node() / cpu_maps_update_begin() / cpu_bootable()
      └─ _cpu_up(cpu, 0, CPUHP_BP_KICK_AP)
         ├─ cpus_write_lock()
         ├─ cpuhp_set_state()
         └─ cpuhp_up_callbacks(cpu, st, CPUHP_BP_KICK_AP)
            └─ cpuhp_invoke_callback_range(true, cpu, st, target)
               └─ __cpuhp_invoke_callback_range(true, cpu, st, target, false)
                  └─ while (cpuhp_next_state(...)) ...
                     └─ cpuhp_invoke_callback(cpu, CPUHP_BP_KICK_AP, true, NULL, NULL)
                        └─ cb = step->startup.single
                           ret = cb(cpu)
                           └─ cpuhp_kick_ap_alive(cpu)
                              └─ arch_cpuhp_kick_ap_alive(cpu, idle_thread_get(cpu))
                                 └─ smp_ops.kick_ap_alive(cpu, tidle)  arch/x86/kernel/smpboot.c
                                    └─ native_kick_ap(cpu, tidle)      arch/x86/kernel/smp.c:290
                                       ├─ apic->cpu_present_to_apicid(cpu)
                                       ├─ mtrr_save_state()

I understand that spamming a ton of pr_info's, especially in a latency-sensitive
path such as the cpu-hotplug-bootstrap paths, can widen timing windows
significantly, so please ignore the rambling...

Out of sheer curiosity (insanity?), while waiting for the debug kernel to
compile, I removed the smp_call_function_single() invocation of
mtrr_save_fixed_ranges() in mtrr_save_state() in one my experiments.

<snip>
void mtrr_save_state(void)
{
	int first_cpu;

	if (!mtrr_enabled())
		return;

	pr_info("getting first cpu in cpumask in mtrr_save_state");
	first_cpu = cpumask_first(cpu_online_mask);
	pr_info("saving range registers in cpu %u", first_cpu);
    /* COMMENTED OUT */
	//smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
}
</snip>

I could've been bleary eyed and lost track of "which kernel was running where"
-- but I was unable to reproduce the issue at all here.

Anyway, I am hoping to collect some meaningful results from the trace data. In the
meantime, I was revisiting the subject of the bisect and the changes introduced to
8250_port.c.

Specifically, I was curious if serial8250_console_write_thread() could
potentially be the culprit, especially given the fact that we are running in
CONFIG_PREEMPT_VOLUNTARY as opposed to CONFIG_PREEMPT_RT.

My understanding is shaky at best here, but specifically:

<snip>
	while (!nbcon_enter_unsafe(wctxt))
		nbcon_reacquire(wctxt);

	/* Finally, wait for transmitter to become empty and restore IER. */
	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
	if (em485) {
		mdelay(port->rs485.delay_rts_after_send);
		if (em485->tx_stopped)
			up->rs485_stop_tx(up);
	}
	serial_port_out(port, UART_IER, ier);
</snip>

Is it possible that we just spin here? That we somehow lost ownership at some
point during the secondary CPU startup sequence and cannot restore UART_IER?
Would this explain the silent console + hang at PID1?

If that is not the case (very plausible) -- what I am still very unsure of, is
how the atomic 8250 implementation here could affect the rdmsr()s in
save/get_fixed_ranges(), to the point of intermittently stalling in the Hyper-V
VM (MTRR virtualization / SMT sibling) environment?

<snip>
static void get_fixed_ranges(mtrr_type *frs)
{
	unsigned int *p = (unsigned int *)frs;
	int i;

	k8_check_syscfg_dram_mod_en();

	rdmsr(MSR_MTRRfix64K_00000, p[0], p[1]);

	for (i = 0; i < 2; i++)
		rdmsr(MSR_MTRRfix16K_80000 + i, p[2 + i * 2], p[3 + i * 2]);
	for (i = 0; i < 8; i++)
		rdmsr(MSR_MTRRfix4K_C0000 + i, p[6 + i * 2], p[7 + i * 2]);
}

void mtrr_save_fixed_ranges(void *info)
{
	return;
	if (boot_cpu_has(X86_FEATURE_MTRR))
		get_fixed_ranges(mtrr_state.fixed_ranges);
}
</snip>

I would appreciate the pointers. I am also very OOTL wrt patches and such that
have hit the mailing lists lately.

Many thanks in advance,

-- 
Derek <debarbos@redhat.com>

