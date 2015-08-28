From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH rt-tests 0/4] build tweaks and a bug fix
Date: Fri, 28 Aug 2015 10:54:00 -0700
Message-ID: <20150828175400.GB33809@vmdeb7>
References: <cover.1440720422.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Darren Hart <dvhart@linux.intel.com>,
	Robert Yang <liezhi.yang@windriver.com>,
	Kai Kang <kai.kang@windriver.com>,
	"Song.Li" <Song.Li@windriver.com>,
	Jesse Zhang <sen.zhang@windriver.com>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49161 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbbH1RyH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Aug 2015 13:54:07 -0400
Content-Disposition: inline
In-Reply-To: <cover.1440720422.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Aug 27, 2015 at 07:19:47PM -0500, Josh Cartwright wrote:
> Hey John, Clark-
> 
> This series has a few minor rt-tests tweaks that make it a bit easier to build
> and package rt-tests for the bizarro build demands in the embedded space.  With
> a bug fix thrown in for good measure.
> 
> The first patch breaks the assumption that build host == target; the second
> patch allows a packager to more easily split hwlatdetect into a separate
> package.  (Both of these patches are unchanged since Darren's original
> submission in 2012[1]).

Yikes, did I not submit those to rt-tests? If not, shame on me!

> 
> The third patch works around crappy gzip implementations.
> 
> The forth patch fixes a hypothetical (as far as I know) bug in hackbench's
> error handling.
> 
> A form of all of these patches has been carried out-of-tree in the OpenEmbedded
> project for years now :(.  They are more widely useful; as such, it's time to
> land them in rt-tests proper.
> 
> Thanks,
>   Josh
> 
> 1: http://permalink.gmane.org/gmane.linux.rt.user/8749
> 
> Cc: Darren Hart <dvhart@linux.intel.com>
> Cc: Robert Yang <liezhi.yang@windriver.com>
> Cc: Kai Kang <kai.kang@windriver.com>
> Cc: Song.Li <Song.Li@windriver.com>
> Cc: Jesse Zhang <sen.zhang@windriver.com>
> 
> Darren Hart (2):
>   rt-tests: Allow for user-specified PYLIB
>   rt-tests: Break out install_hwlatdetect
> 

Re-Acked, thanks Josh.

-- 
Darren Hart
Intel Open Source Technology Center
