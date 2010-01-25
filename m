From: Julian Fuchs <julian@fuchs.cc>
Subject: Re: Problem with interrupt handler
Date: Mon, 25 Jan 2010 23:41:46 +0100
Message-ID: <e97c14da1001251441n7860119bxccaf773d541401b1@mail.gmail.com>
References: <e97c14da1001250916u9b20444k2bdb550211aca1ea@mail.gmail.com>
	 <20100125193104.GC14834@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f186.google.com ([209.85.223.186]:56881 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165Ab0AYWls convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jan 2010 17:41:48 -0500
Received: by iwn16 with SMTP id 16so226422iwn.5
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2010 14:41:46 -0800 (PST)
In-Reply-To: <20100125193104.GC14834@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

thank you very much for your answer.

Am 25. Januar 2010 20:31 schrieb Uwe Kleine-K=F6nig
<u.kleine-koenig@pengutronix.de>:
> On Mon, Jan 25, 2010 at 06:16:08PM +0100, Julian Fuchs wrote:
(...)
> Did you try with IRQF_NODELAY on vanilla and without it in rt?

I tried it with IRQF_NODELAY in rt and without IRQF_NODELAY on vanilla
(vanilla won't compile with IRQF_NODELAY AFAIR).

> Are you sure the irq fires in rt?

It fires in the normal kernel (i.e. the hardware is working). How can
I determine whether the interrupt fires in rt?

> =A0Does your interrupt appear in /proc/interrupts?

Yes, it appears there (and the name of the module is listed correctly
in the same line).

On vanilla, the counter in /proc/interrupts increases, on rt, it
doesn't. It seems that the interrupt just doesn't fire... is there any
kind of "magic" I can do on rt to "enable" the interrupt? It seems
disabled :-(

> What platform are you working on?

I'm working on a Intel Celeron 1,8 GHz board (x86) with Ubuntu Linux
9.10 as a distro.

> =A0Do you can send the code of a minimal example?

Sure. Below you find the code of a minimal example for a rs232
interface. If you have any suggestions for a smaller example, please
tell me and will create it (I just don't know how to create the
interrupt otherwise).

Thanks a lot for your help,

Julian

-----
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/mm.h>
#include <asm/uaccess.h>
#include <linux/sched.h>
#include <linux/ioport.h>
#include <asm/io.h>
#include <linux/proc_fs.h>
#include <linux/inet.h>
#include <linux/net.h>
#include <net/tcp.h>
#include <net/ip.h>
#include <net/protocol.h>


/* --- DEFITIONS AND SETTINGS --- */

// Module information
MODULE_AUTHOR("Somebody");
MODULE_DESCRIPTION("some serial interface driver");
MODULE_LICENSE("GPL");
#define MODULE_IDENT "foobar"
#define VERSION_STRING "foobar v0.1\n"

// Configurable parameters
int base_port =3D 0xcf00;
const int port_range =3D 8;
int irq =3D 16;

int irq_counter =3D 0;

module_param(base_port, int, 0644);
MODULE_PARM_DESC(base_port, "The base port address of the serial interf=
ace");
module_param(irq, int, 0644);
MODULE_PARM_DESC(irq, "IRQ of the serial interface");


// Serial port communication
// registers
#define IER 1 // interrupt enable register
#define FCR 2 // FIFO control register (write) / Interrupt
Identification Register (read)
#define LCR 3 // line control register

// serial port settings
#define PARITY_NO 0x0
#define STOPBIT_1 0
#define CS_8 0x3
#define MAX_BAUDRATE 921600

#define DIVISOR_ACCESS 0x80

// interrupt identification and enabling
#define IER_DATA_AVAILABLE 0x1
#define IER_LS_CHANGE 0x4

// Global control variables
int stage =3D 0;

/* --- SERIAL PORT CONFIGURATION INTERFACE --- */

void set_serial_options(void);

void set_serial_options(void) {
	unsigned int divisor;
	unsigned char parity, stopbit, cs, status;

	stopbit =3D STOPBIT_1;
	parity =3D PARITY_NO;
	cs =3D CS_8;

	status =3D parity | stopbit | cs | DIVISOR_ACCESS;
	outb(status, base_port+LCR);
	divisor =3D 24;
	outb(divisor & 0x00ff, base_port);
	outb(divisor & 0xff00, base_port+1);

	// reset divisor access bit
	outb(status &~ DIVISOR_ACCESS, base_port+LCR);
}


irqreturn_t interrupt_handler(int myirq, void *dev_id) {
=09
	unsigned char iir_byte, bitmask;
	iir_byte =3D inb(base_port + FCR);
	bitmask =3D 1;
	if ( (iir_byte & bitmask) =3D=3D 1) {
		// interrupt is not for this module
		return IRQ_NONE;
	}
	// interrupt is for this module
	unsigned char data_byte;
	data_byte =3D inb(base_port);
=09
	irq_counter++;
=09
	return IRQ_HANDLED;
}


void cleanup_module(void) {
	// I/O ports reserved
	if (stage >=3D 2) {
		release_region(base_port, port_range);
		printk(KERN_INFO "%s: releasing I/O ports\n", MODULE_IDENT);
	}
	// IRQ reserved
	if (stage >=3D 1) {
		// because of shared irq, &stage is given, otherwise NULL will do, to=
o
		free_irq(irq, &stage);
		// disable interrupts from the card
		outb(0, base_port + IER);

		printk(KERN_INFO "%s: freeing irq %i\n", MODULE_IDENT, irq);
	}
	printk(KERN_INFO "%s: module unloaded\n", MODULE_IDENT);
=09
	printk(KERN_ERR "%d irq_counter\n", irq_counter);
}

/* Setup all operations - called by kernel when module is loaded */
int init_module(void) {

	int err =3D 0;

	printk(KERN_INFO VERSION_STRING);

	// Stage 1. Request IRQ using shared interrupts
	// dev_id can't be NULL since the kernel needs to label the different =
ISRs
	// stage is just as a pointer to our address space, any other address
will do, too.
	if ((err =3D request_irq(irq, interrupt_handler, IRQF_SHARED |
IRQF_DISABLED | IRQF_NODELAY, MODULE_IDENT, &stage)) < 0) return err;
	stage++;

	// Stage 2. Request access to I/O ports
	if ((err =3D check_region(base_port, port_range)) < 0) {
		cleanup_module();
		return err;
	}
	request_region(base_port, port_range, MODULE_IDENT);
	stage++;

	printk(KERN_INFO "Using serial port at %x, IRQ %i\n", base_port, irq);

	// Configure serial port
	set_serial_options();

	// disable FIFO
	outb(0, base_port+FCR);

	// enable interrupts if data available or break signal received
	outb(IER_DATA_AVAILABLE | IER_LS_CHANGE, base_port+IER);
=09
	printk(KERN_ERR "INIT MODULE DONE!\n");

	return 0;
}
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
