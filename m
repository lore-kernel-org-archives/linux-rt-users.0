From: Avi Kivity <avi@redhat.com>
Subject: Re: Host latency peaks due to kvm-intel
Date: Sat, 25 Jul 2009 11:15:36 +0300
Message-ID: <4A6ABF28.1010602@redhat.com>
References: <4A68A6E5.6010808@siemens.com> <4A68BD5D.1070302@gmail.com> <4A6981B0.3000008@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <gregory.haskins@gmail.com>,
	kvm-devel <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Yang, Sheng" <sheng.yang@intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:43392 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbZGYIPn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Jul 2009 04:15:43 -0400
In-Reply-To: <4A6981B0.3000008@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/24/2009 12:41 PM, Jan Kiszka wrote:
> I vaguely recall that someone promised to add a feature reporting
> facility for all those nice things, modern VM-extensions may or may not
> support (something like or even an extension of /proc/cpuinfo). What is
> the state of this plan? Would be specifically interesting for Intel CPUs
> as there seem to be many of them out there with restrictions for special
> use cases - like real-time.
>    

Newer kernels do report some vmx features (like flexpriority) in 
/proc/cpuinfo but not all.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

