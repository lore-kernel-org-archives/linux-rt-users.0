From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: High 50us+ latencies in the process signal handling path
Date: Wed, 24 Oct 2007 21:24:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710242123550.13877@gandalf.stny.rr.com>
References: <20071018124827.GA22282@in.ibm.com> <4718A680.5000501@stud.feec.vutbr.cz>
 <200710191950.11664.sripathik@in.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
	Ankita Garg <ankita@in.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Ingo Molnar <mingo@elte.hu>,
	Dinakar Guniguntala <dino@in.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>,
	Mike Kravetz <kravetz@us.ibm.com>
To: Sripathi Kodi <sripathik@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:53884 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbXJYBZf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2007 21:25:35 -0400
In-Reply-To: <200710191950.11664.sripathik@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Fri, 19 Oct 2007, Sripathi Kodi wrote:
> >
> > Can this explain it?
>
> We have changed the sender to be of priority 1 less than the receiver. This
> brings down the frequency of seeing high latencies, especially if there is a
> background load, but does not eliminate them. In fact the logs Ankita posted
> were with the sender at this RT priority.
>

The latest -rt code has new RT balancing. Could you see if 2.6.23-rt3
fixes the issues for you.

-- Steve
