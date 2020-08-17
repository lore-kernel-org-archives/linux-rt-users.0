Return-Path: <SRS0=mgec=B3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E00C433E1
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34882075B
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgHQO4X convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729190AbgHQO4W (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Aug 2020 10:56:22 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 673922072E;
        Mon, 17 Aug 2020 14:56:21 +0000 (UTC)
Date:   Mon, 17 Aug 2020 10:56:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: Question on 5.4.55 merge into 5.4-rt
Message-ID: <20200817105619.6395e654@oasis.local.home>
In-Reply-To: <20200817134109.hu73gjafbdb2n3rz@linutronix.de>
References: <20200814185421.74b1ddc8@oasis.local.home>
        <20200817134109.hu73gjafbdb2n3rz@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 17 Aug 2020 15:41:09 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2020-08-14 18:54:21 [-0400], Steven Rostedt wrote:
> > 
> > When merging 5.4.55 into 5.4-rt I hit the following conflict:  
> …
> > 
> > Where we are doing something slightly different. Placing the skb on the
> > sd->tofree_queue and raising NET_RX_SOFTIQ instead.
> > 
> > Now that the vanilla stable 5.4 kernel doesn't call kfree_skb() from
> > irqs_disabled, can I safely revert this entire change?  
> 
> Not if you mean dropping skbufhead-raw-lock.patch.

Yeah, I realized I worded that incorrectly. No, I meant only reverting
the portion of that patch I showed:

@@ -5229,7 +5234,7 @@ static void flush_backlog(struct work_struct *work)
        skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
                if (skb->dev->reg_state == NETREG_UNREGISTERING) {
                        __skb_unlink(skb, &sd->input_pkt_queue);
-                       kfree_skb(skb);
+                       __skb_queue_tail(&sd->tofree_queue, skb);
                        input_queue_head_incr(sd);
                }
        }
@@ -5239,11 +5244,14 @@ static void flush_backlog(struct work_struct *work)
        skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
                if (skb->dev->reg_state == NETREG_UNREGISTERING) {
                        __skb_unlink(skb, &sd->process_queue);
-                       kfree_skb(skb);
+                       __skb_queue_tail(&sd->tofree_queue, skb);
                        input_queue_head_incr(sd);
                }
        }
+       if (!skb_queue_empty(&sd->tofree_queue))
+               raise_softirq_irqoff(NET_RX_SOFTIRQ);
        local_bh_enable();
+
 }



> 
> We can drop `tofree_queue' and everything related to it. We need to
> keep the `raw_lock' and the `rps_lock()' hunks for
> `sd->input_pkt_queue'. The other queue, `sd->process_queue', is
> protected by local_bh_disable() so these hunks can be dropped in the
> more recent RT versions with the re-written softirq code
> (v5.0.19-rt10+).
> 
> > Is it safe to call kfree_skb() from local_bh_disable()?  
> 
> of course it is.

Then all looks good.

Thanks, I'll push this out to the repos today.

-- Steve
