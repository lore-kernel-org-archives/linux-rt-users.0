From: "Yang, Sheng" <sheng.yang@intel.com>
Subject: Re: Host latency peaks due to kvm-intel
Date: Mon, 27 Jul 2009 09:11:59 +0800
Message-ID: <200907270912.00470.sheng.yang@intel.com>
References: <4A68A6E5.6010808@siemens.com> <4A6AD69E.7030201@web.de> <4A6CAB8B.4080706@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jan Kiszka <jan.kiszka@web.de>, Avi Kivity <avi@redhat.com>,
	Gregory Haskins <gregory.haskins@gmail.com>,
	"kvm-devel" <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: "H. Peter Anvin" <h.peter.anvin@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36929 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754647AbZG0BMi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 26 Jul 2009 21:12:38 -0400
In-Reply-To: <4A6CAB8B.4080706@intel.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Monday 27 July 2009 03:16:27 H. Peter Anvin wrote:
> Jan Kiszka wrote:
> > Avi Kivity wrote:
> >> On 07/24/2009 12:41 PM, Jan Kiszka wrote:
> >>> I vaguely recall that someone promised to add a feature reporting
> >>> facility for all those nice things, modern VM-extensions may or may not
> >>> support (something like or even an extension of /proc/cpuinfo). What is
> >>> the state of this plan? Would be specifically interesting for Intel
> >>> CPUs as there seem to be many of them out there with restrictions for
> >>> special use cases - like real-time.
> >>
> >> Newer kernels do report some vmx features (like flexpriority) in
> >> /proc/cpuinfo but not all.
> >
> > Ah, nice. Then we just need this?
>
> Fine with me.
>
> Acked-by: H. Peter Anvin <hpa@zytor.com>
>
> However, I guess the real question if we shouldn't export ALL VMX
> features in a consistent way instead?
>
When I add feature reporting to cpuinfo, I just put highlight features there, 
otherwise the VMX feature list would at least as long as CPU one.

I have also suggested another field for virtualization feature for it, but 
some concern again userspace tools raised.

For we got indeed quite a lot features, and would get more, would it better to 
export the part of struct vmcs_config entries(that's pin_based_exec_ctrl, 
cpu_based_exec_ctrl, and cpu_based_2nd_exec_ctrl) through 
sys/module/kvm_intel/? Put every feature to cpuinfo seems not that necessary 
for such a big list.

-- 
regards
Yang, Sheng
