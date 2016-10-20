From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: i915 monitor hotplug on 4.1/4.4 PREEMPT
Date: Thu, 20 Oct 2016 15:28:10 +0300
Message-ID: <87r37bqk6d.fsf@intel.com>
References: <CAKP5S=2GhofOeDr7tv32s+WPue+QhtFYUGjdQ7Mxfh91Neh+7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: intel-gfx@lists.freedesktop.org
To: Nicolae Rosia <nicolae.rosia.oss@gmail.com>,
        "linux-rt-users\@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34787 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932267AbcJTM2P (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Oct 2016 08:28:15 -0400
In-Reply-To: <CAKP5S=2GhofOeDr7tv32s+WPue+QhtFYUGjdQ7Mxfh91Neh+7A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 20 Oct 2016, Nicolae Rosia <nicolae.rosia.oss@gmail.com> wrote:
> Monitor hotplugging seems to be broken on latest 4.1/4.4 RT kernel with i915.
> I have tested this on non-RT kernel and it works.
> I get an udev event for unplugging, but there's no event generated for
> plugging the monitor back in.

Does it work on non-RT? Does it work on v4.8 or v4.9-rc1?

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
