From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: Kernel config options that impact latency
Date: Thu, 4 Jan 2018 19:37:36 +0000
Message-ID: <20180104193736.GA5394@osadl.at>
References: <D5D6254030DBC644B6EE58B333BFBB1E9D96DC30@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Hindman, Gavin" <gavin.hindman@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:39810 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbeADThw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Jan 2018 14:37:52 -0500
Content-Disposition: inline
In-Reply-To: <D5D6254030DBC644B6EE58B333BFBB1E9D96DC30@ORSMSX101.amr.corp.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 04, 2018 at 06:29:37PM +0000, Hindman, Gavin wrote:
> Since we seem to be in knowledge-sharing mode, is there an existing list of kernel config parameters, outside of those required to enable preempt_rt, known to impact or improve general system latency?  I didn't find anything prowling the various wikis.
>

Depending on what you mean with general system latency -
isolation related config items will allow you to improve the effectiveness
of pinning rt tasks to specific cores (e.g. cgroups) further
physical isolation like PALLOC (out of tree patch at
https://github.com/heechul/palloc) allow reducing cache side-effects
and L2/L3 sharing which can be a significant latency source.
of course these config items have no effect just by turning them on
but they allow to configure system software architectures that are
more suitable/robust for mixed rt/non-rt workloads.

thx!
hofrat
