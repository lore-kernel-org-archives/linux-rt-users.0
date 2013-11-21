From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH 2/2] remove recursive call to migrate_disable in
	write_lock_bh
Date: Thu, 21 Nov 2013 01:11:18 +0100
Message-ID: <20131121001118.GA26317@opentech.at>
References: <20131120102734.GA3793@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:33770 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847Ab3KUALU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Nov 2013 19:11:20 -0500
Content-Disposition: inline
In-Reply-To: <20131120102734.GA3793@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi !

 "[PATCH 2/2] remove recursive call to migrate_disable in write_lock_bh"
 seems to be blowing up in unpin_current_cpu - seems that I still did not
 get the dependencies between interleved write_lock_bh/read_unlock,
 read_unlock/write_lock_bh right...

thx!
hofrat 
