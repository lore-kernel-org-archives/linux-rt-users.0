From: Theodore Tso <tytso@mit.edu>
Subject: Re: List archive broken?
Date: Tue, 19 Dec 2006 15:21:37 -0500
Message-ID: <20061219202137.GA11035@thunk.org>
References: <45883424.8070909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, larsi+gmane@gnus.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:46655 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932942AbWLSVFO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Dec 2006 16:05:14 -0500
To: Dirk Behme <dirk.behme@googlemail.com>
Content-Disposition: inline
In-Reply-To: <45883424.8070909@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Dec 19, 2006 at 07:49:08PM +0100, Dirk Behme wrote:
> I just tried the list archive
> 
> http://news.gmane.org/gmane.linux.rt.user
> 
> but looks like there is only some other trash?
> 
> Best seems to be
> 
> http://rss.gmane.org/gmane.linux.rt.user
> 
> But there only the last postings seem to be accessible. And 
> clicking on one of the links there, gives the correct text, 
> but sender and date is broken as well, like "zako  | 11 Apr 
> 23:56".

It looks like some spammers got a hold of the input address for the
gmane.org site for the linux-rt-users mailing list and directed spam
directly into gmane.org.  That seems the to be most likely case given
that the spam isn't present at the mail-archive.com archive site nor
for those of us directly subscribed to the linux-rt-users mailing
list:

   http://www.mail-archive.com/linux-rt-users@vger.kernel.org

It looks like the spam messages were deleted, probably when someone
reported the messages as Spam on the gmane.org web interface.
However, it looks like the index files weren't adjusted at
http://news.gmane.org/gmane.linux.rt.user web site.  The
blog.gmane.org site is in slightly better condition; the top level
page isn't showing anything useful, but the month of December page
seems to show recent messages:

	http://blog.gmane.org/gmane.linux.rt.user/month=20061201

Interestingly enough, the list of messages found here:

	http://news.gmane.org/gmane.linux.rt.user

only has spam, and doesn't have anything newer than December 11th.  So
I'm guessing that the spam was elimiated, but at least some of the
web-based index files aren't being updated for the past week or so.

Fortunately, it looks like the mail-archive.com archive site is
working OK, and I have my own personal copy of mailing list archived
(although I don't have anything set up to make it available on the web
site; but it's could be used to setup up a pipermail site or I can
make it available to gmane.org if for some reason their data files are
scrambled beyond the need for recovery --- what, me paranoid?)

I've cc'ed Lars Magne Ingerigsten, who is one of the administrators
for gmane.org, in the hopes he can take a look at things and
straighten them out.  Lars, let me know if I can help in any way.

						- Ted
