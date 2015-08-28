From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH rt-tests 0/4] build tweaks and a bug fix
Date: Fri, 28 Aug 2015 12:50:13 -0500
Message-ID: <20150828125013.77d181b0@sluggy>
References: <cover.1440720422.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Darren Hart <dvhart@linux.intel.com>,
	Robert Yang <liezhi.yang@windriver.com>,
	Kai Kang <kai.kang@windriver.com>,
	"Song.Li" <Song.Li@windriver.com>,
	Jesse Zhang <sen.zhang@windriver.com>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58932 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962AbbH1RuQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Aug 2015 13:50:16 -0400
In-Reply-To: <cover.1440720422.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 27 Aug 2015 19:19:47 -0500
Josh Cartwright <joshc@ni.com> wrote:

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

These look reasonable to me Josh. I'll pull 'em in and we'll beat on
them for a while.

Clark
