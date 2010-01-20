From: Julian Fuchs <julian@fuchs.cc>
Subject: Problem with interrupt handler for serial 16550 interface
Date: Wed, 20 Jan 2010 23:04:41 +0100
Message-ID: <e97c14da1001201404xab4be4fw94fb7613652dab14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f196.google.com ([209.85.223.196]:52168 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab0ATWEo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2010 17:04:44 -0500
Received: by iwn34 with SMTP id 34so4082114iwn.21
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Jan 2010 14:04:43 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I'm trying to write a kernel module for a standard 16550
rs232-interface on intel x86 (Intel Celeron 1,8 GHz).

It works with the plain kernel from kernel.org (2.6.31), but not with
2.6.31.6-rt19.

The purpose of the module is the following: when an interrupt is
received from the hardware the value of irq_counter is increased by 1
(this is a very small example to show the problem).

The hardware generates around 4000 interrupts per second, the settings
for the serial interface are 38400, no parity, 1 stopbit and 8 bit
character size.

Without the CONFIG_PREEMPT_RT patch (and without the
IRQF_NODELAY-flag), the module works like it is expected to do (I can
watch the rising number of IRQs for IRQ 16 in /proc/interrupts and I
get the value of irq_counter when I unload the module).

With CONFIG_PREEMPT_RT, I get the error message "IRQ 16 device foobar
returned IRQ_WAKE_THREAD but no thread function available." and it
seems that the interrupt handler doesn't get called (I can see no
rising IRQ counts in /proc/interrupts either).

Are there any mistakes in the code? Is there a special way to deal
with interrupts in PREEMPT_RT? I use the IRQF_NODELEAY and
IRQF_DISABLED as it is mentioned in the rt-wiki.

I do the following steps:

1. request_irq(irq, interrupt_handler, IRQF_SHARED | IRQF_DISABLED |
IRQF_NODELAY, MODULE_IDENT, &stage)
2. request_region(base_port, port_range, MODULE_IDENT);

(The complete code is below)

I would really appreciate any help!

If you have any hints or need more information please let me know.

So long,
Julian




----------------------------------------------
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
int base_port = 0xcf00;
const int port_range = 8;
int irq = 16;

int irq_counter = 0;

module_param(base_port, int, 0644);
MODULE_PARM_DESC(base_port, "The base port address of the serial interface");
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
int stage = 0;

/* --- SERIAL PORT CONFIGURATION INTERFACE --- */

void set_serial_options(void);

void set_serial_options(void) {
	unsigned int divisor;
	unsigned char parity, stopbit, cs, status;

	stopbit = STOPBIT_1;
	parity = PARITY_NO;
	cs = CS_8;

	status = parity | stopbit | cs | DIVISOR_ACCESS;
	outb(status, base_port+LCR);
	divisor = 24;
	outb(divisor & 0x00ff, base_port);
	outb(divisor & 0xff00, base_port+1);

	// reset divisor access bit
	outb(status &~ DIVISOR_ACCESS, base_port+LCR);
}


irqreturn_t interrupt_handler(int myirq, void *dev_id) {
	
	unsigned char iir_byte, bitmask;
	iir_byte = inb(base_port + FCR);
	bitmask = 1;
	if ( (iir_byte & bitmask) == 1) {
		// interrupt is not for this module
		return IRQ_NONE;
	}
	// interrupt is for this module
	unsigned char data_byte;
	data_byte = inb(base_port);
	
	irq_counter++;
	
	return IRQ_HANDLED;
}


void cleanup_module(void) {
	// I/O ports reserved
	if (stage >= 2) {
		release_region(base_port, port_range);
		printk(KERN_INFO "%s: releasing I/O ports\n", MODULE_IDENT);
	}
	// IRQ reserved
	if (stage >= 1) {
		// because of shared irq, &stage is given, otherwise NULL will do, too
		free_irq(irq, &stage);
		// disable interrupts from the card
		outb(0, base_port + IER);

		printk(KERN_INFO "%s: freeing irq %i\n", MODULE_IDENT, irq);
	}
	printk(KERN_INFO "%s: module unloaded\n", MODULE_IDENT);
	
	printk(KERN_ERR "%d irq_counter\n", irq_counter);
}

/* Setup all operations - called by kernel when module is loaded */
int init_module(void) {

	int err = 0;

	printk(KERN_INFO VERSION_STRING);

	// Stage 1. Request IRQ using shared interrupts
	// dev_id can't be NULL since the kernel needs to label the different ISRs
	// stage is just as a pointer to our address space, any other address
will do, too.
	if ((err = request_irq(irq, interrupt_handler, IRQF_SHARED |
IRQF_DISABLED | IRQF_NODELAY, MODULE_IDENT, &stage)) < 0) return err;
	stage++;

	// Stage 2. Request access to I/O ports
	if ((err = check_region(base_port, port_range)) < 0) {
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
	
	printk(KERN_ERR "INIT MODULE DONE!\n");

	return 0;
}
