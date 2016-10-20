From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [Intel-gfx] i915 monitor hotplug on 4.1/4.4 PREEMPT
Date: Thu, 20 Oct 2016 17:08:50 +0300
Message-ID: <87h987qfil.fsf@intel.com>
References: <CAKP5S=2GhofOeDr7tv32s+WPue+QhtFYUGjdQ7Mxfh91Neh+7A@mail.gmail.com> <87r37bqk6d.fsf@intel.com> <20161020125708.GB8202@suiko.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nicolae Rosia <nicolae.rosia.oss@gmail.com>,
        "linux-rt-users\@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
To: David Weinehall <tao@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54879 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756773AbcJTOIx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Oct 2016 10:08:53 -0400
In-Reply-To: <20161020125708.GB8202@suiko.acc.umu.se>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 20 Oct 2016, David Weinehall <tao@kernel.org> wrote:
> On Thu, Oct 20, 2016 at 03:28:10PM +0300, Jani Nikula wrote:
>> On Thu, 20 Oct 2016, Nicolae Rosia <nicolae.rosia.oss@gmail.com> wrote:
>> > Monitor hotplugging seems to be broken on latest 4.1/4.4 RT kernel with i915.
>> > I have tested this on non-RT kernel and it works.
>
> The answer to your first question seems to be here :)

*blush*

>> > I get an udev event for unplugging, but there's no event generated for
>> > plugging the monitor back in.
>> 
>> Does it work on non-RT? Does it work on v4.8 or v4.9-rc1?
>
> The second one is relevant though. 4.1 is pre-historic, 4.4 is ancient.

I think the honest answer here is that we do not have the resources to
debug RT vs. non-RT issues all that much in general, and especially not
for such old kernels. RT is not in our focus, and hotplug has proved to
be hard enough on non-RT. Nothing to be proud of, but we have 500+ bugs
open over at the freedesktop.org bugzilla, most for relatively recent
non-RT kernels.

Even if we fixed this upstream (and it would have to be fixed upstream
to be backported) it's a huge problem that the feedback loop for RT
kernels has such a long delay. If we break something for RT, it takes
forever for us to find out.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
