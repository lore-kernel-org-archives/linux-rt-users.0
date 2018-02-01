From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: Kernel config options that impact latency
Date: Thu, 1 Feb 2018 10:40:44 -0800
Message-ID: <4b4f6310-bd54-77d8-51d0-216352746357@intel.com>
References: <D5D6254030DBC644B6EE58B333BFBB1E9D96DC30@ORSMSX101.amr.corp.intel.com>
 <20180104193736.GA5394@osadl.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Nicholas Mc Guire <der.herr@hofr.at>,
        "Hindman, Gavin" <gavin.hindman@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56662 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751988AbeBASkp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Feb 2018 13:40:45 -0500
In-Reply-To: <20180104193736.GA5394@osadl.at>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Nicholas,

On 1/4/2018 11:37 AM, Nicholas Mc Guire wrote:
> On Thu, Jan 04, 2018 at 06:29:37PM +0000, Hindman, Gavin wrote:
>> Since we seem to be in knowledge-sharing mode, is there an existing list of kernel config parameters, outside of those required to enable preempt_rt, known to impact or improve general system latency?  I didn't find anything prowling the various wikis.
>>
> 
> Depending on what you mean with general system latency -
> isolation related config items will allow you to improve the effectiveness
> of pinning rt tasks to specific cores (e.g. cgroups) further
> physical isolation like PALLOC (out of tree patch at
> https://github.com/heechul/palloc) allow reducing cache side-effects
> and L2/L3 sharing which can be a significant latency source.
> of course these config items have no effect just by turning them on
> but they allow to configure system software architectures that are
> more suitable/robust for mixed rt/non-rt workloads.

If you do have the option to use Intel hardware then please do consider
Cache Allocation Technology (CAT) instead. With CAT it is possible to
isolate portions of cache and assign cores or tasks to the different
portions in order to control the amount of cache space into which these
entities can fill. CAT thus provides hardware support for the isolation
and prioritization of key tasks you seek. Additional benefits of CAT are
that it is supported in the Linux kernel from v4.10 and there is no
guessing needed from user space on which address bits determine cache
sets (which is increasingly hard to do).

More details about Linux support of CAT can be found in
Documentation/x86/intel_rdt_ui.txt within the kernel source (v4.10+). A
technical blog about the Linux implementation is at
https://01.org/intel-rdt-linux/blogs/fyu1/2017/resource-allocation-intel%C2%AE-resource-director-technology

Reinette

