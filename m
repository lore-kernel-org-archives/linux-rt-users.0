From: "Yang, Sheng" <sheng.yang@intel.com>
Subject: Re: cpuinfo and HVM features (was: Host latency peaks due to kvm-intel)
Date: Mon, 27 Jul 2009 17:29:11 +0800
Message-ID: <200907271729.13142.sheng.yang@intel.com>
References: <4A68A6E5.6010808@siemens.com> <200907270912.00470.sheng.yang@intel.com> <4A6D6E9A.6030400@siemens.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Anvin, H Peter" <h.peter.anvin@intel.com>,
	Avi Kivity <avi@redhat.com>,
	Gregory Haskins <gregory.haskins@gmail.com>,
	"kvm-devel" <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755895AbZG0J3y@vger.kernel.org>
In-Reply-To: <4A6D6E9A.6030400@siemens.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Monday 27 July 2009 17:08:42 Jan Kiszka wrote:
> [ carrying this to LKML ]
>
> Yang, Sheng wrote:
> > On Monday 27 July 2009 03:16:27 H. Peter Anvin wrote:
> >> Jan Kiszka wrote:
> >>> Avi Kivity wrote:
> >>>> On 07/24/2009 12:41 PM, Jan Kiszka wrote:
> >>>>> I vaguely recall that someone promised to add a feature reporting
> >>>>> facility for all those nice things, modern VM-extensions may or may
> >>>>> not support (something like or even an extension of /proc/cpuinfo).
> >>>>> What is the state of this plan? Would be specifically interesting for
> >>>>> Intel CPUs as there seem to be many of them out there with
> >>>>> restrictions for special use cases - like real-time.
> >>>>
> >>>> Newer kernels do report some vmx features (like flexpriority) in
> >>>> /proc/cpuinfo but not all.
> >>>
> >>> Ah, nice. Then we just need this?
> >>
> >> Fine with me.
> >>
> >> Acked-by: H. Peter Anvin <hpa@zytor.com>
> >>
> >> However, I guess the real question if we shouldn't export ALL VMX
> >> features in a consistent way instead?
> >
> > When I add feature reporting to cpuinfo, I just put highlight features
> > there, otherwise the VMX feature list would at least as long as CPU one.
>
> That could become true. But the question is always what the highlights
> are. Often this depends on the hypervisor as it may implement
> workarounds for missing features differently (or not at all). So I'm
> also for exposing feature information consistently.

(CC Andi and Ingo)

The highlight means the feature we would gain a lot, like FlexPriority, EPT, 
VPID. They can be vendor specific. And I am talking about hardware capability 
here, so what's hypervisor did for workaround is not in scope.
>
> > I have also suggested another field for virtualization feature for it,
> > but some concern again userspace tools raised.
> >
> > For we got indeed quite a lot features, and would get more, would it
> > better to export the part of struct vmcs_config entries(that's
> > pin_based_exec_ctrl, cpu_based_exec_ctrl, and cpu_based_2nd_exec_ctrl)
> > through
> > sys/module/kvm_intel/? Put every feature to cpuinfo seems not that
> > necessary for such a big list.
>
> I don't think this information should only come from KVM. Consider you
> didn't build it into some kernel but still want to find out what your
> system is able to provide.

Yes, agree.
>
> What about adding some dedicated /proc entry for CPU virtualization
> features, say /proc/hvminfo?

Well, compared to this, I may still prefer a new item in /proc/cpuinfo, for 
it's still CPU feature, like Andi did for power management(IIRC).

Any more preferred location?

-- 
regards
Yang, Sheng
