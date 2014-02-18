From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: locking changes in tty broke low latency feature
Date: Tue, 18 Feb 2014 10:38:30 +0100
Message-ID: <20140218093829.GC1741@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

setserial has low_latency option which should minimize receive latency
(scheduler delay). AFAICT it is used if someone talk to external device
via RS-485/RS-232 and need to have quick requests and responses . On
kernel this feature was implemented by direct tty processing from
interrupt context:

void tty_flip_buffer_push(struct tty_port *port)
{
        struct tty_bufhead *buf = &port->buf;

        buf->tail->commit = buf->tail->used;

        if (port->low_latency)
                flush_to_ldisc(&buf->work);
        else
                schedule_work(&buf->work);
} 

But after 3.12 tty locking changes, calling flush_to_ldisc() from
interrupt context is a bug (we got scheduling while atomic bug report
here: https://bugzilla.redhat.com/show_bug.cgi?id=1065087 )

I'm not sure how this should be solved. After Peter get rid all of those
race condition in tty layer, we probably don't want go back to use
spin_lock's there. Maybe we can create WQ_HIGHPRI workqueue and schedule
flush_to_ldisc() work there. Or perhaps users that need to low latency,
should switch to thread irq and prioritize serial irq to meat
retirements. Anyway setserial low_latency is now broken and all who use
this feature in the past can not do this any longer on 3.12+ kernels.
 
Thoughts ?

Stanislaw

