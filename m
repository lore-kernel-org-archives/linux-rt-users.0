Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1E2770F
	for <linux-rt-users@vger.kernel.org>; Tue,  3 Oct 2023 13:48:07 +0000 (UTC)
Received: from smtpcmd11125.aruba.it (smtpcmd11125.aruba.it [62.149.156.125])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B71AD
	for <linux-rt-users@vger.kernel.org>; Tue,  3 Oct 2023 06:48:01 -0700 (PDT)
Received: from eurosoft.it ([10.10.10.165])
	by Aruba Outgoing Smtp  with ESMTPA
	id nfkjqBC7HUzD5nfkjqBbf9; Tue, 03 Oct 2023 15:47:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1696340877; bh=HI69micI7KwDh97b68qchlpuJKXffK9YCYEFamP5H64=;
	h=Date:Subject:MIME-Version:Content-Type:From:To;
	b=bN9NcpUXryWKNhv+ZBxqmytdgcOTPlCA4oRj5XdAyQXDiA/WQo1Y+42/jtx2PMWlM
	 tCHD8atzF+EAEu0NPM7ZdfG1PUBJltvBh3FiXcXigftsRVDX0gHax6mwByeujNJAep
	 Yp8Rd9Qq8er/oKZtb6WEmOE8KCwiG4kV3K+At11T6slYlzgrxyrbBuKYNtByDR+EnO
	 bikAIUdxyO3TQsMEwfQ+JANOgGV8FsD15JOSUtv4e3ylzQm3eLvn9AVAxNEPv4dhJb
	 2/LK6KZ36RSAJ0TfdJr5hM0/9paA+BZ2LNSBSSG52T7EOP8Z/tRC4ypoAmnc10qwH1
	 iO84QO6fEAj2g==
Date: Tue,  3 Oct 2023 15:47:57 +0200
Message-Id: <S1YGZX$2ABA0246807C0BA80101FD71365D4784@eurosoft.it>
Subject: Re: High latency of a system based on 5.19 rt
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: multipart/mixed;
	boundary="_=__=_XaM3_.1696340877.2A.767640.42.7767.52.42.007.1517934600"
Reply-To: g.medini@eurosoft.it
From: g.medini@eurosoft.it
To: bigeasy@linutronix.de
Cc: linux-rt-users@vger.kernel.org
X-XaM3-API-Version: 4.2.88
X-TipoRicevuta: completa
X-type: 0
X-SenderIP: 93.57.102.244
X-CMAE-Envelope: MS4xfPuUYBdmyk64/GNuSHJZ4ZDadd/vN+u0CusifhkpdiUfiKVnOpGZoZCcnrUmCs9Lqhf+uvDvvByxCF9m5liFGCemJrWSZWTE9L584ylP+2w1LAMkKmgl
 oS5V77NmXkR6/dDkXLNrGCfiIDNqUCULjIZZXm1Qnh1Kkg7sNBRR8PvupvzgdbMsV36Ysp2T1jD7OnSNOWh53S3XaGND4azoQHaZiOHwI8gEmoNJXzv5Gi4g
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--_=__=_XaM3_.1696340877.2A.767640.42.7767.52.42.007.1517934600
Content-Type: multipart/alternative;
	boundary="_=__=_XaM3_.1696340877.2A.767700.42.7767.52.42.007.209933430"


--_=__=_XaM3_.1696340877.2A.767700.42.7767.52.42.007.209933430
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A   Good afternoon, I've tried to reproduce the issue with CONFIG_X86_D=
EBUG_FPU but I was not able to do since was depending from the enviromnen=
t where I run an rt-task that executes an Ethercat master with an high pr=
iority rt-task (priority 60).=0A=0A   On a system free of rt-task wakeup_=
rt trace shows the attached trace in the particular condition I press the=
 windows like button (and X resize graphical windows continously).=0A   I=
n my rt task at the end the high latency is connected with this type of g=
raphical activity so I think could be better investigate the system free =
of my rt-task.=0A   Actually I have also tested the stable 5.15 but the m=
ain issue remains the same.=0A   Gianluca=0A   Da "Sebastian Andrzej Siew=
ior" bigeasy@linutronix.de=0A   A g.medini@eurosoft.it=0A   Cc linux-rt-u=
sers@vger.kernel.org=0A   Data Mon, 2 Oct 2023 12:02:57 +0200=0A   Oggett=
o Re: High latency of a system based on 5.19 rt=0A   On 2023-09-25 18:30:=
44 [+0200], g.medini@eurosoft.it wrote:=0A   >=0A   > Hi All, I'm struggl=
ing with a realtime issue I have.=0A   Hi,=0A=0A   > Using trace I've fou=
nd a problem related to CONFIG_X86_DEBUG_FPU that was introducing very la=
rge latency.=0A=0A   Do you have a trace and numeric value of "very large=
 latency" for=0A   CONFIG_X86_DEBUG_FPU?=0A=0A   > Removing this I have a=
nother one where the solution is not so trivial.=0A   >=0A   > The proble=
m I've actually seems related to i915 driver.=0A   >=0A   > With a partic=
ular load for the graphic card (basically using ALT-TAB to switch from gr=
aphical windows or pressing the Win like button to resize all the graphic=
al windows to the screen) I see an huge latency that gives problem to an =
rt task I need for my application.=0A   >=0A   > I've tried everything to=
 optimize the sytem.=0A   >=0A   > As expected I find little enhancement =
that help me to mitigate the problem (core isolation and so on) but the b=
asic problem remain the same (it happens with X11 and Wayland also).=0A=0A=
   What is the latency problem? The wake up trace shows a wake up from=0A=
   gnome to irq-work. Is the graphic/ i915 lagging or something else?=0A=0A=
   > Hoping someone can help me.=0A   >=0A   > Gianluca=0A   >=0A   > Cor=
diali saluti=0A   > Best regards=0A=0A   Sebastian=0A
--_=__=_XaM3_.1696340877.2A.767700.42.7767.52.42.007.209933430
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<span style=3D"font-family: Arial; font-size: medium;" xam-editor-contain=
er=3D"true"><br />Good afternoon, I've tried to reproduce the issue with =
CONFIG_X86_DEBUG_FPU but I was not able to do since was depending from th=
e enviromnent where I run an rt-task that executes an Ethercat master wit=
h an high priority rt-task (priority 60).<div><br /><div>On a system free=
 of rt-task wakeup_rt trace shows the attached trace in the particular co=
ndition I press the windows like button (and X resize graphical windows c=
ontinously).</div><div><br /></div><div>In my rt task at the end the high=
 latency is connected with this type of graphical activity so I think cou=
ld be better investigate the system free of my rt-task.</div><div><br /><=
/div><div>Actually I have also tested the stable 5.15 but the main issue =
remains the same.</div><div><br /></div><div>Gianluca</div><div><br /><di=
v data-signature-id=3D"1">=0A<div class=3D"xam_msg_class">=0A<span style=3D=
"font-family: Arial; font-size: medium;" xam-editor-container=3D"true"><d=
iv style=3D"color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-s=
erif; font-size: small; background-color: rgb(255, 255, 255);"><div id=3D=
"m_6813077285459221634AppleMailSignature" style=3D"color: rgb(0, 0, 0); f=
ont-family: Helvetica; font-size: 14px;"><div><table border=3D"0" cellpad=
ding=3D"0" cellspacing=3D"0" width=3D"600px"><tbody><tr><td style=3D"marg=
in: 0px;" width=3D"10"></td><td colspan=3D"5" height=3D"10" style=3D"marg=
in: 0px; border-top: 1px dotted rgb(174, 174, 174);"></td><td style=3D"ma=
rgin: 0px;" width=3D"10"></td></tr></tbody><tbody><tr><td style=3D"margin=
: 0px;" width=3D"10"></td><td colspan=3D"5" style=3D"margin: 0px;"><br />=
<br /></td><td style=3D"margin: 0px;" width=3D"10"><br /></td></tr></tbod=
y><tbody><tr><td style=3D"margin: 0px;" width=3D"10"><br /></td><td colsp=
an=3D"5" height=3D"10" style=3D"margin: 0px; border-top: 1px dotted rgb(1=
74, 174, 174);"><br /></td><td style=3D"margin: 0px;" width=3D"10"></td><=
/tr></tbody><tbody><tr><td style=3D"margin: 0px;" width=3D"10"></td><td a=
lign=3D"right" style=3D"margin: 0px;" width=3D"20"></td><td align=3D"cent=
er" style=3D"margin: 0px;" width=3D"120"></td><td style=3D"margin: 0px;" =
width=3D"20"></td><td style=3D"margin: 0px;" width=3D"10"></td><td style=3D=
"margin: 0px;"></td><td style=3D"margin: 0px;" width=3D"10"><br /></td></=
tr><tr><td style=3D"margin: 0px;" width=3D"10"></td><td colspan=3D"5" hei=
ght=3D"20px" style=3D"margin: 0px;"></td></tr><tr><td style=3D"margin: 0p=
x;" width=3D"10"></td><td align=3D"left" colspan=3D"5" style=3D"margin: 0=
px; color: rgb(149, 152, 154); font-family: Arial, Helvetica, sans-serif;=
 font-size: 11px; line-height: 14px; padding: 10px; background-color: rgb=
(236, 236, 236);"><br /></td></tr></tbody></table></div><br /></div></div=
></span>=0A</div>=0A</div><br /><br /><div class=3D"xam-quoted-text xam-r=
eply-text"><div style=3D"border-left: 3px solid #000000; padding-left: 10=
px;"><div><span style=3D"font-family:Arial; font-size:11px; color:#5F5F5F=
;">Da</span><span style=3D"font-family:Arial; font-size:12px; color:#5F5F=
5F; padding-left:5px;"> &quot;Sebastian Andrzej Siewior&quot; bigeasy@lin=
utronix.de</span></div>=0A<div><span style=3D"font-family:Arial; font-siz=
e:11px; color:#5F5F5F;">A</span><span style=3D"font-family:Arial; font-si=
ze:12px; color:#5F5F5F; padding-left:5px;"> g.medini@eurosoft.it</span></=
div>=0A<div><span style=3D"font-family:Arial; font-size:11px; color:#5F5F=
5F;">Cc</span><span style=3D"font-family:Arial; font-size:12px; color:#5F=
5F5F; padding-left:5px;"> linux-rt-users@vger.kernel.org</span></div>=0A<=
div><span style=3D"font-family:Arial; font-size:11px; color:#5F5F5F;">Dat=
a</span><span style=3D"font-family:Arial; font-size:12px; color:#5F5F5F; =
padding-left:5px;"> Mon, 2 Oct 2023 12:02:57 +0200</span></div>=0A<div><s=
pan style=3D"font-family:Arial; font-size:11px; color:#5F5F5F;">Oggetto</=
span><span style=3D"font-family:Arial; font-size:12px; color:#5F5F5F; pad=
ding-left:5px;"> Re: High latency of a system based on 5.19 rt</span></di=
v>=0A<br />=0A<div>On 2023-09-25 18:30:44 [+0200], g.medini@eurosoft.it w=
rote:</div><div>&gt; </div><div>&gt;    Hi All, I'm struggling with a rea=
ltime issue I have.</div><div>Hi,</div><div>=C2=A0</div><div>&gt;    Usin=
g trace I've found a problem related to CONFIG_X86_DEBUG_FPU that was int=
roducing very large latency.</div><div>=C2=A0</div><div>Do you have a tra=
ce and numeric value of &quot;very large latency&quot; for</div><div>CONF=
IG_X86_DEBUG_FPU?</div><div>=C2=A0</div><div>&gt;    Removing this I have=
 another one where the solution is not so trivial.</div><div>&gt; </div><=
div>&gt;    The problem I've actually seems related to i915 driver.</div>=
<div>&gt; </div><div>&gt;    With a particular load for the graphic card =
(basically using ALT-TAB to switch from graphical windows or pressing the=
 Win like button to resize all the graphical windows to the screen) I see=
 an huge latency that gives problem to an rt task I need for my applicati=
on.</div><div>&gt; </div><div>&gt;    I've tried everything to optimize t=
he sytem.</div><div>&gt; </div><div>&gt;    As expected I find little enh=
ancement that help me to mitigate the problem (core isolation and so on) =
but the basic problem remain the same (it happens with X11 and Wayland al=
so).</div><div>=C2=A0</div><div>What is the latency problem? The wake up =
trace shows a wake up from</div><div>gnome to irq-work. Is the graphic/ i=
915 lagging or something else?</div><div>=C2=A0</div><div>&gt;    Hoping =
someone can help me.</div><div>&gt; </div><div>&gt;    Gianluca</div><div=
>&gt; </div><div>&gt;    Cordiali saluti</div><div>&gt;    Best regards</=
div><div>=C2=A0</div><div>Sebastian</div></div></div></div></div></span>
--_=__=_XaM3_.1696340877.2A.767700.42.7767.52.42.007.209933430--

--_=__=_XaM3_.1696340877.2A.767640.42.7767.52.42.007.1517934600
Content-Type: text/plain; name="=?utf-8?Q?wakeup=5Frt.txt?="
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="=?utf-8?Q?wakeup=5Frt.txt?="

# tracer: wakeup_rt=0A#=0A# wakeup_rt latency trace v1.1.5 on 5.19.0-rt10=
=0A# --------------------------------------------------------------------=
=0A# latency: 371 us, #227/227, CPU#0 | (M:preempt_rt VP:0, KP:0, SP:0 HP=
:0 #P:2)=0A#    -----------------=0A#    | task: irq_work/0-23 (uid:0 nic=
e:0 policy:1 rt_prio:1)=0A#    -----------------=0A#=0A#                 =
   _--------=3D> CPU#            =0A#                   / _-------=3D> ir=
qs-off/BH-disabled=0A#                  | / _------=3D> need-resched    =0A=
#                  || / _-----=3D> need-resched-lazy=0A#                 =
 ||| / _----=3D> hardirq/softirq =0A#                  |||| / _---=3D> pr=
eempt-depth   =0A#                  ||||| / _--=3D> preempt-lazy-depth=0A=
#                  |||||| / _-=3D> migrate-disable =0A#                  =
||||||| /     delay           =0A#  cmd     pid     |||||||| time  |   ca=
ller     =0A#     \   /        ||||||||  \    |    /       =0A    Xorg-77=
1       0dn.h512    1us!:      771:120:R   + [000]      23: 98:R irq_work=
/0=0A    Xorg-771       0dn.h512  114us : <stack trace>=0A =3D> __ftrace_=
trace_stack=0A =3D> probe_wakeup=0A =3D> ttwu_do_wakeup=0A =3D> try_to_wa=
ke_up=0A =3D> __sysvec_irq_work=0A =3D> sysvec_irq_work=0A =3D> asm_sysve=
c_irq_work=0A =3D> native_apic_mem_read=0A =3D> native_apic_wait_icr_idle=
=0A =3D> irq_work_queue=0A =3D> i915_request_enable_breadcrumb=0A =3D> __=
dma_fence_enable_signaling=0A =3D> dma_fence_add_callback=0A =3D> i915_sw=
_fence_await_dma_fence=0A =3D> i915_sw_fence_await_reservation=0A =3D> in=
tel_prepare_plane_fb=0A =3D> drm_atomic_helper_prepare_planes=0A =3D> int=
el_atomic_commit=0A =3D> drm_atomic_helper_page_flip=0A =3D> drm_mode_pag=
e_flip_ioctl=0A =3D> drm_ioctl_kernel=0A =3D> drm_ioctl=0A =3D> __x64_sys=
_ioctl=0A =3D> do_syscall_64=0A =3D> entry_SYSCALL_64_after_hwframe=0A   =
 Xorg-771       0dn.h512  115us : 0=0A    Xorg-771       0dn.h412  118us =
: task_woken_rt <-ttwu_do_wakeup=0A    Xorg-771       0dn.h412  118us : p=
reempt_count_sub <-try_to_wake_up=0A    Xorg-771       0dn.h312  120us : =
_raw_spin_unlock_irqrestore <-try_to_wake_up=0A    Xorg-771       0dn.h31=
2  121us : preempt_count_sub <-_raw_spin_unlock_irqrestore=0A    Xorg-771=
       0dn.h212  121us : preempt_count_sub <-try_to_wake_up=0A    Xorg-77=
1       0dn.h112  123us : irq_exit_rcu <-sysvec_irq_work=0A    Xorg-771  =
     0dn.h112  123us : preempt_count_sub <-__irq_exit_rcu=0A    Xorg-771 =
      0dn..112  125us : idle_cpu <-__irq_exit_rcu=0A    Xorg-771       0d=
n..112  126us+: raw_irqentry_exit_cond_resched <-irqentry_exit=0A    Xorg=
-771       0dn..112  174us : irq_enter_rcu <-sysvec_apic_timer_interrupt=0A=
    Xorg-771       0dn..112  174us : preempt_count_add <-irq_enter_rcu=0A=
    Xorg-771       0dn.h112  176us : __sysvec_apic_timer_interrupt <-sysv=
ec_apic_timer_interrupt=0A    Xorg-771       0dn.h112  181us : hrtimer_in=
terrupt <-__sysvec_apic_timer_interrupt=0A    Xorg-771       0dn.h112  18=
6us : _raw_spin_lock_irqsave <-hrtimer_interrupt=0A    Xorg-771       0dn=
.h112  186us : preempt_count_add <-_raw_spin_lock_irqsave=0A    Xorg-771 =
      0dn.h212  187us : ktime_get_update_offsets_now <-hrtimer_interrupt=0A=
    Xorg-771       0dn.h212  189us : __hrtimer_run_queues <-hrtimer_inter=
rupt=0A    Xorg-771       0dn.h212  191us : _raw_spin_unlock_irqrestore <=
-__hrtimer_run_queues=0A    Xorg-771       0dn.h212  191us : preempt_coun=
t_sub <-_raw_spin_unlock_irqrestore=0A    Xorg-771       0dn.h112  192us =
: tick_sched_timer <-__hrtimer_run_queues=0A    Xorg-771       0dn.h112  =
193us : ktime_get <-tick_sched_timer=0A    Xorg-771       0dn.h112  193us=
 : tick_sched_do_timer <-tick_sched_timer=0A    Xorg-771       0dn.h112  =
195us : tick_do_update_jiffies64 <-tick_sched_do_timer=0A    Xorg-771    =
   0dn.h112  197us : _raw_spin_lock <-tick_do_update_jiffies64=0A    Xorg=
-771       0dn.h112  197us : preempt_count_add <-_raw_spin_lock=0A    Xor=
g-771       0dn.h212  201us : calc_global_load <-tick_do_update_jiffies64=
=0A    Xorg-771       0dn.h212  202us : preempt_count_sub <-tick_do_updat=
e_jiffies64=0A    Xorg-771       0dn.h112  202us : update_wall_time <-tic=
k_sched_do_timer=0A    Xorg-771       0dn.h112  202us : timekeeping_advan=
ce <-update_wall_time=0A    Xorg-771       0dn.h112  202us : _raw_spin_lo=
ck_irqsave <-timekeeping_advance=0A    Xorg-771       0dn.h112  202us : p=
reempt_count_add <-_raw_spin_lock_irqsave=0A    Xorg-771       0dn.h212  =
208us : ntp_tick_length <-timekeeping_advance=0A    Xorg-771       0dn.h2=
12  209us : ntp_tick_length <-timekeeping_advance=0A    Xorg-771       0d=
n.h212  209us : timekeeping_update <-timekeeping_advance=0A    Xorg-771  =
     0dn.h212  209us : ntp_get_next_leap <-timekeeping_update=0A    Xorg-=
771       0dn.h212  210us : update_vsyscall <-timekeeping_update=0A    Xo=
rg-771       0dn.h212  214us : raw_notifier_call_chain <-timekeeping_upda=
te=0A    Xorg-771       0dn.h212  215us : update_fast_timekeeper <-timeke=
eping_update=0A    Xorg-771       0dn.h212  217us : update_fast_timekeepe=
r <-timekeeping_update=0A    Xorg-771       0dn.h212  218us : _raw_spin_u=
nlock_irqrestore <-timekeeping_advance=0A    Xorg-771       0dn.h212  218=
us : preempt_count_sub <-_raw_spin_unlock_irqrestore=0A    Xorg-771      =
 0dn.h112  219us : tick_sched_handle <-tick_sched_timer=0A    Xorg-771   =
    0dn.h112  219us : update_process_times <-tick_sched_handle=0A    Xorg=
-771       0dn.h112  220us : account_process_tick <-update_process_times=0A=
    Xorg-771       0dn.h112  222us : account_system_time <-update_process=
_times=0A    Xorg-771       0dn.h112  222us : account_system_index_time <=
-update_process_times=0A    Xorg-771       0dn.h112  224us : cpuacct_acco=
unt_field <-account_system_index_time=0A    Xorg-771       0dn.h112  225u=
s : __cgroup_account_cputime_field <-account_system_index_time=0A    Xorg=
-771       0dn.h112  225us : preempt_count_add <-__cgroup_account_cputime=
_field=0A    Xorg-771       0dn.h212  227us : cgroup_base_stat_cputime_ac=
count_end.constprop.0 <-account_system_index_time=0A    Xorg-771       0d=
n.h212  227us : cgroup_rstat_updated <-cgroup_base_stat_cputime_account_e=
nd.constprop.0=0A    Xorg-771       0dn.h212  227us : preempt_count_sub <=
-cgroup_base_stat_cputime_account_end.constprop.0=0A    Xorg-771       0d=
n.h112  227us : acct_account_cputime <-update_process_times=0A    Xorg-77=
1       0dn.h112  229us : hrtimer_run_queues <-update_process_times=0A   =
 Xorg-771       0dn.h112  229us : raise_timer_softirq <-update_process_ti=
mes=0A    Xorg-771       0dn.h112  230us : wake_up_process <-raise_timer_=
softirq=0A    Xorg-771       0dn.h112  230us : try_to_wake_up <-raise_tim=
er_softirq=0A    Xorg-771       0dn.h112  231us : preempt_count_add <-try=
_to_wake_up=0A    Xorg-771       0dn.h212  231us : _raw_spin_lock_irqsave=
 <-try_to_wake_up=0A    Xorg-771       0dn.h212  231us : preempt_count_ad=
d <-_raw_spin_lock_irqsave=0A    Xorg-771       0dn.h312  232us : kthread=
_is_per_cpu <-is_cpu_allowed=0A    Xorg-771       0dn.h312  235us : ttwu_=
queue_wakelist <-try_to_wake_up=0A    Xorg-771       0dn.h312  235us : pr=
eempt_count_add <-try_to_wake_up=0A    Xorg-771       0dn.h412  235us : _=
raw_spin_lock <-try_to_wake_up=0A    Xorg-771       0dn.h412  235us : pre=
empt_count_add <-_raw_spin_lock=0A    Xorg-771       0dn.h512  236us : pr=
eempt_count_sub <-try_to_wake_up=0A    Xorg-771       0dn.h412  236us : u=
pdate_rq_clock <-try_to_wake_up=0A    Xorg-771       0dn.h412  236us : tt=
wu_do_activate <-try_to_wake_up=0A    Xorg-771       0dn.h412  236us : ps=
i_task_change <-ttwu_do_activate=0A    Xorg-771       0dn.h412  237us : p=
si_flags_change <-psi_task_change=0A    Xorg-771       0dn.h412  238us : =
psi_group_change <-ttwu_do_activate=0A    Xorg-771       0dn.h412  239us =
: enqueue_task_rt <-ttwu_do_activate=0A    Xorg-771       0dn.h412  239us=
 : dequeue_rt_stack <-enqueue_task_rt=0A    Xorg-771       0dn.h412  239u=
s : dequeue_top_rt_rq <-dequeue_rt_stack=0A    Xorg-771       0dn.h412  2=
40us : update_rt_migration <-enqueue_task_rt=0A    Xorg-771       0dn.h41=
2  241us : _raw_spin_lock <-enqueue_task_rt=0A    Xorg-771       0dn.h412=
  241us : preempt_count_add <-_raw_spin_lock=0A    Xorg-771       0dn.h51=
2  241us : preempt_count_sub <-enqueue_task_rt=0A    Xorg-771       0dn.h=
412  241us : enqueue_top_rt_rq <-enqueue_task_rt=0A    Xorg-771       0dn=
.h412  241us : ttwu_do_wakeup <-try_to_wake_up=0A    Xorg-771       0dn.h=
412  241us : check_preempt_curr <-ttwu_do_wakeup=0A    Xorg-771       0dn=
.h412  241us : resched_curr <-check_preempt_curr=0A    Xorg-771       0dn=
.h412  243us : task_woken_rt <-ttwu_do_wakeup=0A    Xorg-771       0dn.h4=
12  243us : preempt_count_sub <-try_to_wake_up=0A    Xorg-771       0dn.h=
312  243us : _raw_spin_unlock_irqrestore <-try_to_wake_up=0A    Xorg-771 =
      0dn.h312  243us : preempt_count_sub <-_raw_spin_unlock_irqrestore=0A=
    Xorg-771       0dn.h212  244us : preempt_count_sub <-try_to_wake_up=0A=
    Xorg-771       0dn.h112  244us : rcu_sched_clock_irq <-update_process=
_times=0A    Xorg-771       0dn.h112  245us : rcu_is_cpu_rrupt_from_idle =
<-rcu_sched_clock_irq=0A    Xorg-771       0dn.h112  246us : rcu_is_cpu_r=
rupt_from_idle <-rcu_sched_clock_irq=0A    Xorg-771       0dn.h112  248us=
 : wake_up_process <-update_process_times=0A    Xorg-771       0dn.h112  =
248us : try_to_wake_up <-update_process_times=0A    Xorg-771       0dn.h1=
12  249us : preempt_count_add <-try_to_wake_up=0A    Xorg-771       0dn.h=
212  249us : _raw_spin_lock_irqsave <-try_to_wake_up=0A    Xorg-771      =
 0dn.h212  249us : preempt_count_add <-_raw_spin_lock_irqsave=0A    Xorg-=
771       0dn.h312  250us : _raw_spin_unlock_irqrestore <-try_to_wake_up=0A=
    Xorg-771       0dn.h312  250us : preempt_count_sub <-_raw_spin_unlock=
_irqrestore=0A    Xorg-771       0dn.h212  252us : preempt_count_sub <-tr=
y_to_wake_up=0A    Xorg-771       0dn.h112  253us : scheduler_tick <-upda=
te_process_times=0A    Xorg-771       0dn.h112  254us : arch_scale_freq_t=
ick <-scheduler_tick=0A    Xorg-771       0dn.h112  256us : preempt_count=
_add <-scheduler_tick=0A    Xorg-771       0dn.h212  256us : _raw_spin_lo=
ck <-scheduler_tick=0A    Xorg-771       0dn.h212  256us : preempt_count_=
add <-_raw_spin_lock=0A    Xorg-771       0dn.h312  257us : preempt_count=
_sub <-scheduler_tick=0A    Xorg-771       0dn.h212  257us : update_rq_cl=
ock <-scheduler_tick=0A    Xorg-771       0dn.h212  257us : task_tick_fai=
r <-scheduler_tick=0A    Xorg-771       0dn.h212  258us : update_curr <-t=
ask_tick_fair=0A    Xorg-771       0dn.h212  259us : update_min_vruntime =
<-update_curr=0A    Xorg-771       0dn.h212  259us : cpuacct_charge <-upd=
ate_curr=0A    Xorg-771       0dn.h212  260us : __cgroup_account_cputime =
<-update_curr=0A    Xorg-771       0dn.h212  260us : preempt_count_add <-=
__cgroup_account_cputime=0A    Xorg-771       0dn.h312  260us : cgroup_ba=
se_stat_cputime_account_end.constprop.0 <-update_curr=0A    Xorg-771     =
  0dn.h312  260us : cgroup_rstat_updated <-cgroup_base_stat_cputime_accou=
nt_end.constprop.0=0A    Xorg-771       0dn.h312  261us : preempt_count_s=
ub <-cgroup_base_stat_cputime_account_end.constprop.0=0A    Xorg-771     =
  0dn.h212  262us : __update_load_avg_se <-update_load_avg=0A    Xorg-771=
       0dn.h212  264us : __update_load_avg_cfs_rq <-update_load_avg=0A   =
 Xorg-771       0dn.h212  265us : update_cfs_group <-task_tick_fair=0A   =
 Xorg-771       0dn.h212  266us : hrtimer_active <-task_tick_fair=0A    X=
org-771       0dn.h212  267us : update_curr <-task_tick_fair=0A    Xorg-7=
71       0dn.h212  267us : update_min_vruntime <-update_curr=0A    Xorg-7=
71       0dn.h212  269us : __update_load_avg_se <-update_load_avg=0A    X=
org-771       0dn.h212  269us : __update_load_avg_cfs_rq <-update_load_av=
g=0A    Xorg-771       0dn.h212  269us : update_cfs_group <-task_tick_fai=
r=0A    Xorg-771       0dn.h212  270us : reweight_entity <-task_tick_fair=
=0A    Xorg-771       0dn.h212  270us : update_curr <-reweight_entity=0A =
   Xorg-771       0dn.h212  270us : hrtimer_active <-task_tick_fair=0A   =
 Xorg-771       0dn.h212  270us : sched_slice <-task_tick_fair=0A    Xorg=
-771       0dn.h212  271us : __calc_delta <-sched_slice=0A    Xorg-771   =
    0dn.h212  272us : calc_global_load_tick <-scheduler_tick=0A    Xorg-7=
71       0dn.h212  272us : preempt_count_sub <-scheduler_tick=0A    Xorg-=
771       0dn.h112  273us : perf_event_task_tick <-scheduler_tick=0A    X=
org-771       0dn.h112  274us : trigger_load_balance <-update_process_tim=
es=0A    Xorg-771       0dn.h112  274us : run_posix_cpu_timers <-tick_sch=
ed_handle=0A    Xorg-771       0dn.h112  276us : profile_tick <-tick_sche=
d_timer=0A    Xorg-771       0dn.h112  277us : hrtimer_forward <-tick_sch=
ed_timer=0A    Xorg-771       0dn.h112  278us : _raw_spin_lock_irq <-__hr=
timer_run_queues=0A    Xorg-771       0dn.h112  278us : preempt_count_add=
 <-_raw_spin_lock_irq=0A    Xorg-771       0dn.h212  279us : enqueue_hrti=
mer <-__hrtimer_run_queues=0A    Xorg-771       0dn.h212  279us : hrtimer=
_update_next_event <-hrtimer_interrupt=0A    Xorg-771       0dn.h212  279=
us : __hrtimer_next_event_base <-hrtimer_update_next_event=0A    Xorg-771=
       0dn.h212  280us : __hrtimer_next_event_base <-hrtimer_update_next_=
event=0A    Xorg-771       0dn.h212  280us : _raw_spin_unlock_irqrestore =
<-hrtimer_interrupt=0A    Xorg-771       0dn.h212  280us : preempt_count_=
sub <-_raw_spin_unlock_irqrestore=0A    Xorg-771       0dn.h112  281us : =
tick_program_event <-hrtimer_interrupt=0A    Xorg-771       0dn.h112  281=
us : clockevents_program_event <-hrtimer_interrupt=0A    Xorg-771       0=
dn.h112  282us : ktime_get <-clockevents_program_event=0A    Xorg-771    =
   0dn.h112  282us : lapic_next_deadline <-clockevents_program_event=0A  =
  Xorg-771       0dn.h112  283us : irq_exit_rcu <-sysvec_apic_timer_inter=
rupt=0A    Xorg-771       0dn.h112  283us : preempt_count_sub <-__irq_exi=
t_rcu=0A    Xorg-771       0dn..112  284us : wake_up_process <-__irq_exit=
_rcu=0A    Xorg-771       0dn..112  284us : try_to_wake_up <-__irq_exit_r=
cu=0A    Xorg-771       0dn..112  284us : preempt_count_add <-try_to_wake=
_up=0A    Xorg-771       0dn..212  284us : _raw_spin_lock_irqsave <-try_t=
o_wake_up=0A    Xorg-771       0dn..212  284us : preempt_count_add <-_raw=
_spin_lock_irqsave=0A    Xorg-771       0dn..312  284us : _raw_spin_unloc=
k_irqrestore <-try_to_wake_up=0A    Xorg-771       0dn..312  284us : pree=
mpt_count_sub <-_raw_spin_unlock_irqrestore=0A    Xorg-771       0dn..212=
  284us : preempt_count_sub <-try_to_wake_up=0A    Xorg-771       0dn..11=
2  285us : idle_cpu <-__irq_exit_rcu=0A    Xorg-771       0dn..112  285us=
 : raw_irqentry_exit_cond_resched <-irqentry_exit=0A    Xorg-771       0.=
n..112  285us : preempt_count_sub <-irq_work_queue=0A    Xorg-771       0=
dn..112  290us : rcu_note_context_switch <-__schedule=0A    Xorg-771     =
  0dn..112  290us : _raw_spin_lock <-rcu_note_context_switch=0A    Xorg-7=
71       0dn..112  293us : preempt_count_add <-_raw_spin_lock=0A    Xorg-=
771       0dn..212  295us : preempt_count_sub <-rcu_note_context_switch=0A=
    Xorg-771       0dn..112  295us : rcu_qs <-rcu_note_context_switch=0A =
   Xorg-771       0dn..112  295us : preempt_count_add <-__schedule=0A    =
Xorg-771       0dn..212  295us : _raw_spin_lock <-__schedule=0A    Xorg-7=
71       0dn..212  295us : preempt_count_add <-_raw_spin_lock=0A    Xorg-=
771       0dn..312  296us : preempt_count_sub <-__schedule=0A    Xorg-771=
       0dn..212  296us : update_rq_clock <-__schedule=0A    Xorg-771     =
  0dn..212  296us : balance_fair <-__schedule=0A    Xorg-771       0dn..2=
12  296us : put_prev_task_fair <-__schedule=0A    Xorg-771       0dn..212=
  296us : put_prev_entity <-put_prev_task_fair=0A    Xorg-771       0dn..=
212  298us : update_curr <-put_prev_entity=0A    Xorg-771       0dn..212 =
 298us : __update_load_avg_se <-update_load_avg=0A    Xorg-771       0dn.=
.212  299us : __update_load_avg_cfs_rq <-update_load_avg=0A    Xorg-771  =
     0dn..212  299us : put_prev_entity <-put_prev_task_fair=0A    Xorg-77=
1       0dn..212  299us : update_curr <-put_prev_entity=0A    Xorg-771   =
    0dn..212  299us : __update_load_avg_se <-update_load_avg=0A    Xorg-7=
71       0dn..212  300us : __update_load_avg_cfs_rq <-update_load_avg=0A =
   Xorg-771       0dn..212  300us : pick_next_task_stop <-__schedule=0A  =
  Xorg-771       0dn..212  301us : pick_next_task_dl <-__schedule=0A    X=
org-771       0dn..212  301us : pick_next_task_rt <-__schedule=0A    Xorg=
-771       0dn..212  302us : update_rt_rq_load_avg <-pick_next_task_rt=0A=
    Xorg-771       0d...212  304us : __do_set_cpus_allowed <-__schedule=0A=
    Xorg-771       0d...212  306us : dequeue_task_fair <-__do_set_cpus_al=
lowed=0A    Xorg-771       0d...212  309us : dequeue_entity <-dequeue_tas=
k_fair=0A    Xorg-771       0d...212  309us : update_curr <-dequeue_entit=
y=0A    Xorg-771       0d...212  309us : __update_load_avg_se <-update_lo=
ad_avg=0A    Xorg-771       0d...212  309us : __update_load_avg_cfs_rq <-=
update_load_avg=0A    Xorg-771       0d...212  309us : clear_buddies <-de=
queue_entity=0A    Xorg-771       0d...212  310us : update_cfs_group <-de=
queue_entity=0A    Xorg-771       0d...212  310us : dequeue_entity <-dequ=
eue_task_fair=0A    Xorg-771       0d...212  310us : update_curr <-dequeu=
e_entity=0A    Xorg-771       0d...212  310us : __update_load_avg_se <-up=
date_load_avg=0A    Xorg-771       0d...212  310us : __update_load_avg_cf=
s_rq <-update_load_avg=0A    Xorg-771       0d...212  311us : clear_buddi=
es <-dequeue_entity=0A    Xorg-771       0d...212  311us : update_cfs_gro=
up <-dequeue_entity=0A    Xorg-771       0d...212  311us : reweight_entit=
y <-dequeue_entity=0A    Xorg-771       0d...212  311us : hrtick_update <=
-__do_set_cpus_allowed=0A    Xorg-771       0d...212  311us : set_cpus_al=
lowed_common <-__do_set_cpus_allowed=0A    Xorg-771       0d...212  312us=
 : enqueue_task_fair <-__schedule=0A    Xorg-771       0d...212  312us : =
enqueue_entity <-enqueue_task_fair=0A    Xorg-771       0d...212  312us :=
 update_curr <-enqueue_entity=0A    Xorg-771       0d...212  313us : __up=
date_load_avg_se <-update_load_avg=0A    Xorg-771       0d...212  313us :=
 __update_load_avg_cfs_rq <-update_load_avg=0A    Xorg-771       0d...212=
  313us : update_cfs_group <-enqueue_entity=0A    Xorg-771       0d...212=
  313us : enqueue_entity <-enqueue_task_fair=0A    Xorg-771       0d...21=
2  314us : update_curr <-enqueue_entity=0A    Xorg-771       0d...212  31=
4us : __update_load_avg_se <-update_load_avg=0A    Xorg-771       0d...21=
2  315us : __update_load_avg_cfs_rq <-update_load_avg=0A    Xorg-771     =
  0d...212  315us : update_cfs_group <-enqueue_entity=0A    Xorg-771     =
  0d...212  316us : reweight_entity <-enqueue_entity=0A    Xorg-771      =
 0d...212  316us : se_is_idle <-enqueue_entity=0A    Xorg-771       0d...=
212  318us : hrtick_update <-__schedule=0A    Xorg-771       0d...212  31=
9us : psi_task_switch <-__schedule=0A    Xorg-771       0d...212  320us :=
 psi_flags_change <-psi_task_switch=0A    Xorg-771       0d...212  322us =
: psi_flags_change <-psi_task_switch=0A    Xorg-771       0d...212  323us=
 : psi_group_change <-psi_task_switch=0A    Xorg-771       0d...212  324u=
s : psi_group_change <-psi_task_switch=0A    Xorg-771       0d...212  325=
us : psi_group_change <-psi_task_switch=0A    Xorg-771       0d...312  32=
6us : __schedule=0A    Xorg-771       0d...312  326us+:      771:120:R =3D=
=3D> [000]      23: 98:R irq_work/0=0A    Xorg-771       0d...312  370us =
: <stack trace>=0A =3D> __ftrace_trace_stack=0A =3D> probe_wakeup_sched_s=
witch=0A =3D> __schedule=0A =3D> preempt_schedule=0A =3D> preempt_schedul=
e_thunk=0A =3D> irq_work_queue=0A =3D> i915_request_enable_breadcrumb=0A =
=3D> __dma_fence_enable_signaling=0A =3D> dma_fence_add_callback=0A =3D> =
i915_sw_fence_await_dma_fence=0A =3D> i915_sw_fence_await_reservation=0A =
=3D> intel_prepare_plane_fb=0A =3D> drm_atomic_helper_prepare_planes=0A =3D=
> intel_atomic_commit=0A =3D> drm_atomic_helper_page_flip=0A =3D> drm_mod=
e_page_flip_ioctl=0A =3D> drm_ioctl_kernel=0A =3D> drm_ioctl=0A =3D> __x6=
4_sys_ioctl=0A =3D> do_syscall_64=0A =3D> entry_SYSCALL_64_after_hwframe=0A=

--_=__=_XaM3_.1696340877.2A.767640.42.7767.52.42.007.1517934600--

