import { Module, Global, OnModuleInit } from '@nestjs/common'; // NestJS core decorators and interfaces
import { ConfigModule, ConfigService } from '@nestjs/config'; // For managing application configuration
import { Pool } from 'pg'; // PostgreSQL client for Node.js
import { exec } from 'child_process'; // For executing shell commands
import { promisify } from 'util'; // Utility for promisifying functions

// Promisifying the exec function to use async/await
const execPromise = promisify(exec);

// Factory function to create a database connection pool
const databasePoolFactory = async (configService: ConfigService) => {
  const pool = new Pool({
    user: configService.get('PG_DB_USERNAME'), 
    host: configService.get('PG_DB_HOST'), 
    database: configService.get('PG_DB_NAME'), 
    password: configService.get('PG_DB_PASSWORD'), 
    port: configService.get<number>('PG_DB_PORT'), 
    max: 1000, 
  });

 

  return pool; // Return the created pool
};

// Function to run Flyway migrations


// Decorator to make the module globally available
@Global() 
@Module({
  imports: [ConfigModule], // Import ConfigModule for configuration management
  providers: [
    {
      provide: 'DATABASE_POOL', // Define a provider for the database pool
      inject: [ConfigService], // Inject ConfigService to access configuration
      useFactory: databasePoolFactory, // Use the factory function to create the pool
    },
  ],
  exports: ['DATABASE_POOL'], // Export the database pool for use in other modules
})
export class DatabaseModule implements OnModuleInit {
  constructor(private readonly configService: ConfigService) {}

  async onModuleInit() {
    // This function can be used to perform any actions when the module is initialized
    // Currently, it's not being used but can be a place for future logic
  }
}
