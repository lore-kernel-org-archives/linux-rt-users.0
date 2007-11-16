From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RT] 2.6.24-rc2-rt1 drivers/dma/ioat_dma.c compile fix
Date: Fri, 16 Nov 2007 12:16:29 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711161214480.24276@gandalf.stny.rr.com>
References: <BAE9DCEF64577A439B3A37F36F9B691C0371E3E3@orsmsx418.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, Linux-kernel@vger.kernel.org,
	Sven-Thorsten Dietrich <sdietrich@novell.com>
To: "Nelson, Shannon" <shannon.nelson@intel.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762870AbXKPRQz@vger.kernel.org>
In-Reply-To: <BAE9DCEF64577A439B3A37F36F9B691C0371E3E3@orsmsx418.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Fri, 16 Nov 2007, Nelson, Shannon wrote:
> first->async_tx.phys;
> > -       __list_splice(&new_chain, ioat_chan->used_desc.prev);
> > +       list_splice_tail(&new_chain, ioat_chan->used_desc.prev);
> >
>
> NAK.
>
> These functions do insertions differently.  The 'prev' is pointing to
> the last valid descriptor in the queue and you really want to get the
> new_chain stuck on after this.  Your list_splice_tail() will insert the
> new_chain just before it which will muck up the order of the DMA
> requests.
>
> You might have more success with
> 	list_splice_tail(&new_chain, ioat_chan->used_desc);
> where used_desc points to the whole list, rather than using the .prev
> pointer to a specific node.
>
> Please copy me on future ioatdma related comments.
>

And people wonder why we post RT related patches to LKML. This is exactly
why!

Thanks for the response Shannon!

-- Steve
