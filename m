From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: The best queue for RT_PREEMPT
Date: Fri, 4 Apr 2008 21:09:27 +0200
Message-ID: <20080404190927.GT13814@pengutronix.de>
References: <20080404184941.GA21013@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: "Mauricio A. Araya L?pez" <maray@inf.utfsm.cl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:53759 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755953AbYDDTdR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Apr 2008 15:33:17 -0400
Content-Disposition: inline
In-Reply-To: <20080404184941.GA21013@alumnos.inf.utfsm.cl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Apr 04, 2008 at 02:49:41PM -0400, Mauricio A. Araya L?pez wrote:
> I have some experience working on RTAI, and I am trying to do
> something similar to a RT_FIFO. Which is the best method to have a
> FIFO queue between a real-time process and a non real-time process.
> Maybe a pipe is enough, or msgget, or directly have a shared memory
> space, etc... Any comment will be very welcome!

If your communication is message oriented, you can use POSIX Message
Queues. However, you can surely also use any other kind of other method,
as long as you don't lock shared ressources for too long.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

