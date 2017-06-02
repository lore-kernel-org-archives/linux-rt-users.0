From: "Hindman, Gavin" <gavin.hindman@intel.com>
Subject: RE: Intel real-time Linux production kernel
Date: Fri, 2 Jun 2017 19:05:32 +0000
Message-ID: <D5D6254030DBC644B6EE58B333BFBB1E9D67337F@ORSMSX101.amr.corp.intel.com>
References: <D5D6254030DBC644B6EE58B333BFBB1E9D673203@ORSMSX101.amr.corp.intel.com>
 <20170602185015.GB31147@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        "Sapra, Rajesh" <rajesh.sapra@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52174 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbdFBTFf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Jun 2017 15:05:35 -0400
In-Reply-To: <20170602185015.GB31147@jcartwri.amer.corp.natinst.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> -----Original Message-----
> From: Julia Cartwright [mailto:julia@ni.com]
> Sent: Friday, June 02, 2017 11:50 AM
> To: Hindman, Gavin <gavin.hindman@intel.com>
> Cc: linux-rt-users <linux-rt-users@vger.kernel.org>; Sapra, Rajesh
> <rajesh.sapra@intel.com>; Weight, Russell H <russell.h.weight@intel.com>
> Subject: Re: Intel real-time Linux production kernel
> 
> On Fri, Jun 02, 2017 at 06:15:31PM +0000, Hindman, Gavin wrote:
> > Hello everyone,
> >
> > I wanted to make you all aware that Intel is now maintaining a
> > preempt_rt enabled version of our 4.9LTS production kernel located
> > here: https://github.com/01org/linux-intel-4.9/wiki  Support is fairly
> > new, and doesn't extend much beyond integrating preempt_rt at this
> > point, but this is where we will host real-time related optimized
> > kernel configs for Intel platforms, and feature back-ports, etc. as
> > those emerge.
> 
> Hey Gavin-
> 
> Is there a reason why the "real-time related optimized kernel configs"
> don't make their home in an upstream RT release?
If we have general optimized configs, we'll push them 
> 
> I recall speaking with Thomas at the RTLWS in Graz about whether or not the rt-
> devel tree should hold rt-enabled/optimized configs, to which he
> said: "patches welcome".

Hi Julia,

Upstream-first is generally our priority across the board.  If they are reasonably generic/arch-independent config changes we would definitely push them all the way up to rt-devel.  I assumed if they were terribly board/chip-specific, or depended on large backported patch-sets not already held in the rt-devel, they would need another home and the production-kernel tree was a good alternative.  

Thanks,
Gavin
